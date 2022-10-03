resource "aws_iam_instance_profile" "bastion" {
  name = format("%s-instance-profile", var.instance_name)
  role = aws_iam_role.bastion.name
}

resource "aws_iam_role" "bastion" {
  name = format("%s-role", var.instance_name)
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_policy" "bastion" {
  name        = "BastionPolicy"
  description = "Policy for Actions BastionHost"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "eks:*",
          "ecr:*",
          "s3:*",
          "ssm:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bastion-attach" {
  role       = aws_iam_role.bastion.name
  policy_arn = aws_iam_policy.bastion.arn
}
