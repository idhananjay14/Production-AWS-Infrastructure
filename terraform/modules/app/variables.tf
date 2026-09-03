variable "ami_id" {
  description = "AMI ID for the application server"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the application server"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for application servers"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for application servers"
  type        = string
}

variable "min_size" {
  description = "Minimum number of application instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of application instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of application instances"
  type        = number
}

variable "user_data" {
  description = "User data script for application instances"
  type        = string
  default     = ""
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name for application servers"
  type        = string
}

variable "environment" {
  description = "Environment name used for resource naming"
  type        = string
}
