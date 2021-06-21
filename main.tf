provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source        = "./vpc"
  vpc_cidr      = "10.0.0.0/16"
  public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "ec2" {
  source         = "./ec2"
  instance_id    = "ami-09e67e426f25ce0d7"
  instance_type  = "t2.micro"
  security_group = module.vpc.security1_group
  subnets        = module.vpc.public_subnets
  keypair_name   = "photosatya2"
}


module "alb" {
  source       = "./alb"
  vpc_id       = module.vpc.vpc_id
  instance1_id = module.ec2.instance1_id
  instance2_id = module.ec2.instance2_id
  subnet1      = module.vpc.subnet1
  subnet2      = module.vpc.subnet2
}