output "instance_ids" {
  description = "IDs of the application instances"
  value       = aws_instance.app[*].id
}

output "private_ips" {
  description = "Private IP addresses of the application instances"
  value       = aws_instance.app[*].private_ip
}
