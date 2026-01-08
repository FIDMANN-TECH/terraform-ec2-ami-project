resource "aws_instance" "terraform_ec2" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}

resource "aws_ami_from_instance" "custom_ami" {
  name               = var.ami_name
  source_instance_id = aws_instance.terraform_ec2.id
}
