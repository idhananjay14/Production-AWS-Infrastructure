output "asg_cpu_alarm_arn" {
  description = "ARN of the application ASG CPU alarm"
  value       = aws_cloudwatch_metric_alarm.asg_cpu_high.arn
}

output "alb_unhealthy_hosts_alarm_arn" {
  description = "ARN of the ALB unhealthy hosts alarm"
  value       = aws_cloudwatch_metric_alarm.alb_unhealthy_hosts.arn
}

output "rds_cpu_alarm_arn" {
  description = "ARN of the RDS CPU alarm"
  value       = aws_cloudwatch_metric_alarm.rds_cpu_high.arn
}

output "rds_free_storage_alarm_arn" {
  description = "ARN of the RDS free storage alarm"
  value       = aws_cloudwatch_metric_alarm.rds_free_storage_low.arn
}
