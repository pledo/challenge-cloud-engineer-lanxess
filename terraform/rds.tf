locals {
  name    = "pledo-test1-psql"
  region  = "us-east-2"

  #vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-rds"
  }
}


module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "Complete PostgreSQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  #tags = local.tags
}

module "rds" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-rds.git?ref=3ba7984d024e035f7b604b1f96726e6bc527e80d"
  
  identifier = "pledo-test1"
  engine               = "postgres"
  engine_version       = "14"
  family               = "postgres14" # DB parameter group
  major_engine_version = "14"  


  instance_class = "db.t3.micro"
  allocated_storage = 20
  max_allocated_storage = 100

  db_name     = "example"
  username = "postgres"
  #password = "${var.postgres_password}"

  port     = 5432

  manage_master_user_password_rotation              = true
  master_user_password_rotate_immediately           = false
  master_user_password_rotation_schedule_expression = "rate(15 days)"

  multi_az               = false
  db_subnet_group_name   = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  #enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  create_cloudwatch_log_group     = false

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false


  performance_insights_enabled          = false
  #performance_insights_retention_period = 7
  create_monitoring_role                = false
  #monitoring_interval                   = 60
  #monitoring_role_name                  = "example-monitoring-role-name"
  #monitoring_role_use_name_prefix       = true
  #monitoring_role_description           = "Description for monitoring role"


}
