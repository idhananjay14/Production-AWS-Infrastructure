output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the application target group"
  value       = aws_lb_target_group.app.arn
}

output "alb_load_balancer_dimension" {
  description = "CloudWatch LoadBalancer dimension for the ALB"
  value       = aws_lb.this.arn_suffix
}

output "target_group_dimension" {
  description = "CloudWatch TargetGroup dimension for the application target group"
  value       = aws_lb_target_group.app.arn_suffix
}
