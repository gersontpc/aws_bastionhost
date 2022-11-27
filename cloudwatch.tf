resource "aws_cloudwatch_log_group" "this" {
  name              = "/logs/command_line_logs/${var.instance_name}"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}