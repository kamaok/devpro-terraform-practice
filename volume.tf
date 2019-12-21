resource "aws_ebs_volume" "volume_ssd" {
  availability_zone = var.instance_config.availability_zone
  size              = 8
  type              = "gp2"

  tags = {
    Name = "ssd"
  }
}


resource "aws_ebs_volume" "volume_hdd" {
  availability_zone = var.instance_config.availability_zone
  size              = 1
  type              = "standard"

  tags = {
    Name = "hdd"
  }
}


resource "aws_volume_attachment" "ebs_ssd_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.volume_ssd.id
  instance_id = aws_instance.web.id
}

resource "aws_volume_attachment" "ebs_hdd_att" {
  device_name = "/dev/sdg"
  volume_id   = aws_ebs_volume.volume_hdd.id
  instance_id = aws_instance.web.id
}