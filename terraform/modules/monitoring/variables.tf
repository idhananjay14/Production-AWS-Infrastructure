variable "environment" {
  description = "Environment name"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Application Auto Scaling Group name"
  type        = string
}

variable "alb_load_balancer_dimension" {
  description = "ALB CloudWatch LoadBalancer dimension"
  type        = string
}

variable "alb_target_group_dimension" {
  description = "ALB CloudWatch TargetGroup dimension"
  type        = string
}

variable "db_instance_identifier" {
  description = "RDS DB instance identifier"
  type        = string
}

variable "asg_cpu_high_threshold" {
  description = "CPU utilization threshold for the application ASG"
  type        = number
  default     = 80
}

variable "rds_cpu_high_threshold" {
  description = "CPU utilization threshold for RDS"
  type        = number
  default     = 80
}

variable "rds_free_storage_threshold" {
  description = "Minimum RDS free storage threshold in bytes"
  type        = number
  default     = 5368709120
}
