#!/bin/bash
set -e

# Ouput all log
exec > >(tee /var/log/user-data.log|logger -t user-data-extra -s 2>/dev/console) 2>&1

# Make sure we have all the latest updates when we launch this instance
yum update -y
yum upgrade -y

# Install AWS Logs
yum install -y awslogs
systemctl enable awslogsd.service

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
ls -t /var/lib/amazon/ssm/i-0cd393ba1b9e607df/channels

# Configure rsyslog
cat >> /etc/profile << EOF

# Enable CLI Logging
whoami="\$(whoami)@\$(echo $SSH_CONNECTION | awk '{print \$1}')"export PROMPT_COMMAND='RETRN_VAL=\$?;logger -p local6.notice "\$whoami [\$\$] \$(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" )"'
EOF

echo "local6.*    /var/log/commands.log" > /etc/rsyslog.d/bash.conf
echo "/var/log/commands.log" >> /etc/logrotate.d/rsyslog
touch /var/log/commands.log
systemctl restart rsyslog

# Configure aws logs
cat > /etc/awslogs/config/command_logs.conf << EOF
# doc reference https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AgentReference.html
[ec2-commands-log]
datetime_format = %Y-%m-%d %H:%M:%S
file = /var/log/commands.log
log_stream_name = {instance_id}-commands-log
log_group_name = /logs/command_line_logs/${instance_name}
EOF

systemctl start awslogsd.service

echo 'Done initialization'
