provider "aws" {
  region                  = var.aws_region
  profile                 = var.aws_profile
}

resource "random_id" "instance_id" {
  byte_length = 4
}

locals {
  name   = "cloud-playground"
  region = var.cloudplayground_region
  amazon2_ami = data.aws_ami.amazon2.id
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.2"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

module "linux_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 4.3"

  name        = "cloudplayground-linux-sg"
  description = "Security group for cloudplayground linux instances"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}


module "amazon2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.19"

  name           = "cloudplayground-amazon2"
  instance_count = var.amazon2_instance_count

  ami                    = data.aws_ami.amazon2.id
  instance_type          = var.linux_instance_type
  vpc_security_group_ids = [module.vpc.default_security_group_id, module.linux_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = var.aws_key_pair_name

  tags = var.ec2_tags
}

module "ubuntu2004_instances" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.19"

  name                   = "cloudplayground-ubuntu2004"
  instance_count         = var.ubuntu2004_instance_count

  ami                    = data.aws_ami.ubuntu2004.id
  instance_type          = var.linux_instance_type
  vpc_security_group_ids = [module.vpc.default_security_group_id, module.linux_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = var.aws_key_pair_name

  tags                   = var.ec2_tags
}