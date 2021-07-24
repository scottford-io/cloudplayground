////////////////////////////////
// Instance Data

data "aws_ami" "amazon2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

data "aws_ami" "rhel8" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-8.0.0_HVM-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["309956199498"]
}

data "aws_ami" "suse15sp1" {
  most_recent = true

  filter {
    name   = "name"
    values = ["suse-sles-15-sp1-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["013907871322"]
}

data "aws_ami" "ubuntu1804" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "ubuntu2004" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_ami" "debian10" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["136693071363"]
}

data "aws_ami" "suse15" {
  most_recent = true

  filter {
    name   = "name"
    values = ["suse-sles-15-v*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["013907871322"]
}