output "connection_string" {
  value = "ssh -i ~/.ssh/aws-us-east-1-ssh-keys.pem ubuntu@${aws_instance.web.public_ip}"
}
