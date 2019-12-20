resource "aws_vpc" "tf_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform_vpc"
  }
}

resource "aws_internet_gateway" "tf_gw" {
  vpc_id = aws_vpc.tf_vpc.id

  tags = {
    Name = "terraform_gateway"
  }
}

resource "aws_subnet" "tf_subnet" {
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone = var.instance_config.availability_zone
  map_public_ip_on_launch = true
 
  depends_on = [aws_internet_gateway.tf_gw]

   tags = {
    Name = "terraform_subnet"
  }
}

resource "aws_eip" "eip" {
  vpc                       = true
  instance                  = aws_instance.web.id
 
  depends_on                = [aws_internet_gateway.tf_gw]

  tags = {
    Name = "terraform_eip"
  }
}


resource "aws_security_group" "tf_sg" {
  name        = "allow_all_from_whiyelist"
  description = "Allow all INPUT connections from whitelist IP-addresses"
  vpc_id      = aws_vpc.tf_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.whitelist
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_security_group"
  }
}
