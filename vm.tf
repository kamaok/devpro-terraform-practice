data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  availability_zone = var.instance_config.availability_zone
  subnet_id  = aws_subnet.tf_subnet.id
  instance_type = var.instance_config.type
  vpc_security_group_ids = [aws_security_group.tf_sg.id]
  key_name      = "aws-us-east-1-ssh-keys"
  tags = {
    Env = var.instance_config.env
    Name = var.instance_config.name
  }
}


