resource "aws_cloudwatch_metric_alarm" "terraform" {
  alarm_name                = "alarm-ec2-cpu"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = var.cloudwatch_alarm-period
  statistic                 = "Average"
  threshold                 = var.cloudwatch_alarm-threshold
  alarm_description         = var.cloudwatch_alarm-description
  insufficient_data_actions = []
}