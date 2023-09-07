resource "aws_instance" "this" {
  ami           = "ami-f409bae3775dc8e5"
  instance_type = var.instance_type

  security_groups = ["example-sg-"]

  subnet_id = data.aws_subnet.this.id
}

resource "aws_security_group" "example_security_group" {
  name_prefix = "example-sg-"

  vpc_id = data.aws_vpc.this.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["project-vpc"]
  }
}

data "aws_subnet" "this" {
  filter {
    name   = "tag:Name"
    values = ["project-subnet-public1-us-east-1a"]
  }
}