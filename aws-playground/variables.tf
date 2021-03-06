////////////////////////////////
// AWS Connection

variable "aws_profile" {
  default = "default"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_key_pair_name" {}

////////////////////////////////
// VPC Settings

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "cloudplayground-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "cloudplayground-vpc"
  }
}

variable "cloudplayground_region" {
  default = "us-east-1"
}

////////////////////////////////
// EC2 Settings

variable "ec2_tags" {
  description = "Tags to apply to resources created by EC2 module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "cloudplayground-vpc"
  }
}

variable "amazon2_instance_count" {
  default = "0"
}

variable "ubuntu2004_instance_count" {
  default = "0"
}

variable "linux_instance_type" {
  default = "t2.micro"
}

variable "linux_instance_flavor" {
  default = "amazon2"
}

variable "winserver2019_instance_type" {
  default = "t2.micro"
}

variable "winserver2019_instance_count" {
  default = "0"
}

variable "windows_admin_password" {
  default = "cloudplayground1" 
}