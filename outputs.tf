output "instance_id" {
  value = aws_instance.terraform_ec2.id
}

output "ami_id" {
  value = aws_ami_from_instance.custom_ami.id
}
