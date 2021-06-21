provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

/*
resource "aws_key_pair" "mytest-key" {
  key_name   = "my-test-terraform-key-new1"
  public_key = "${file(var.my_public_key)}"
} */

resource "aws_instance" "my-test-instance" {
  count                  = 2
  ami                    = var.instance_id
  instance_type          = var.instance_type
  key_name               = var.keypair_name
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = element(var.subnets, count.index)
  user_data              = data.template_file.init.rendered

  tags = {
    Name = "my-instance-${count.index + 1}"
  }
}

data "template_file" "init" {
  template = file("${path.module}/userdata.tpl")
}
