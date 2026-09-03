variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "db_master_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}
