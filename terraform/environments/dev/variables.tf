variable "aws_region" {
  description = "AWS region for the dev environment"
  type        = string
  default     = "ap-south-1"
}

variable "db_master_password" {
  description = "Master password for the RDS PostgreSQL instance"
  type        = string
  sensitive   = true
}
