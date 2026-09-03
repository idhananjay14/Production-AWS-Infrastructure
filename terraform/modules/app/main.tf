resource "aws_instance" "app" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = var.subnet_ids[count.index]
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile   = var.instance_profile_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  user_data = var.user_data

  tags = {
    Name = "production-app-${count.index + 1}"
  }
}

resource "aws_lb_target_group_attachment" "app" {
  count = var.instance_count

  target_group_arn = var.target_group_arn
  target_id        = aws_instance.app[count.index].id
  port             = 8080
}
