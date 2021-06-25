provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "examplesg" {
  name        = "my-example-sg"
  description = "Allow ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2_instance" {
  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "photosatya2"
  user_data              = data.template_file.init.rendered
  tags = {
    Name = "my-first-ec2-instance"
  }
}

data "template_file" "init" {
  template = file("${path.module}/userdata.tpl")
}