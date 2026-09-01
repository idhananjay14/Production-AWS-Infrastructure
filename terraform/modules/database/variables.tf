variable "identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "database_name" {
  description = "Initial database name"
  type        = string
}

variable "master_username" {
  description = "Master username for the database"
  type        = string
}

variable "master_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "Private DB subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the database"
  type        = string
}
