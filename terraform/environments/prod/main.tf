terraform {
  backend "s3" {
    bucket       = "production-aws-infrastructure-tfstate-396608777141"
    key          = "prod/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  environment = "prod"

  vpc_cidr                 = "10.0.0.0/16"
  availability_zones       = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
  private_app_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  private_db_subnet_cidrs  = ["10.0.21.0/24", "10.0.22.0/24"]
}

module "security_groups" {
  source = "../../modules/security-groups"

  environment = "prod"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  environment = "prod"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id
}

module "iam" {
  source = "../../modules/iam"

  environment = "prod"
}

module "app" {
  source = "../../modules/app"

  environment = "prod"

  ami_id                = "ami-090d68841c2a28756"
  instance_type         = "t3.micro"
  subnet_ids            = module.vpc.private_app_subnet_ids
  security_group_id     = module.security_groups.app_security_group_id
  target_group_arn      = module.alb.target_group_arn
  min_size              = 2
  desired_capacity      = 2
  max_size              = 4
  instance_profile_name = module.iam.instance_profile_name

  user_data = <<-USERDATA
    #!/bin/bash
    dnf install -y python3

    mkdir -p /var/www/app

    cat > /var/www/app/index.html <<'HTML'
    <html>
      <body>
        <h1>Production AWS Infrastructure</h1>
        <p>Application server is healthy.</p>
      </body>
    </html>
    HTML

    cat > /etc/systemd/system/app.service <<'SERVICE'
    [Unit]
    Description=Production App Health Service
    After=network.target

    [Service]
    Type=simple
    WorkingDirectory=/var/www/app
    ExecStart=/usr/bin/python3 -m http.server 8080 --bind 0.0.0.0 --directory /var/www/app
    Restart=always

    [Install]
    WantedBy=multi-user.target
    SERVICE

    systemctl daemon-reload
    systemctl enable --now app.service
  USERDATA
}

module "database" {
  source = "../../modules/database"

  identifier        = "prod-postgres"
  engine_version    = "17"
  instance_class    = "db.t3.micro"
  database_name     = "productiondb"
  master_username   = "appuser"
  master_password   = var.db_master_password
  subnet_ids        = module.vpc.private_db_subnet_ids
  security_group_id = module.security_groups.db_security_group_id
}

module "monitoring" {
  source = "../../modules/monitoring"

  environment                 = "prod"
  autoscaling_group_name      = module.app.autoscaling_group_name
  alb_load_balancer_dimension = module.alb.alb_load_balancer_dimension
  alb_target_group_dimension  = module.alb.target_group_dimension
  db_instance_identifier      = module.database.db_instance_id
}
