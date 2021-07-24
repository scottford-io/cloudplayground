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

////////////////////////////////
// VPC Configuration

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

////////////////////////////////
// Linux Security Groups

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

////////////////////////////////
// Linux Instances

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

////////////////////////////////
// Windows Security Groups

module "windows_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 4.3"

  name        = "cloudplayground-windows-sg"
  description = "Security group for cloudplayground windows instances"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5985
      to_port     = 5986
      protocol    = "tcp"
      description = "Winrm ports"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port    = 0
      to_port      = 0
      protocol     = "-1"
      cidr_blocks  = "0.0.0.0/0"
    }
  ]
}
////////////////////////////////
// Windows Security Groups

module "windows2019_instances" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.19"

  name                   = "cloudplayground-win2019"
  instance_count         = var.winserver2019_instance_count

  ami                    = data.aws_ami.winserver2019.id
  instance_type          = var.winserver2019_instance_type
  vpc_security_group_ids = [module.vpc.default_security_group_id, module.windows_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = var.aws_key_pair_name

  tags                   = var.ec2_tags
}