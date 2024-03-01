# Configure the AWS provider
provider "aws" {
  region = "us-west-2"  # Specify your desired region
}

# Create a new key pair
resource "aws_key_pair" "my_keypair" {
  key_name   = "my-keypair"
  public_key = file("~/.ssh/id_rsa.pub")  # Specify the path to your public key
}

# Create a security group
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Allow inbound SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

# Launch an EC2 instance
resource "aws_instance" "my_instance" {
  ami                    = "ami-0c55b159cbfafe1f0"  # Specify your desired AMI
  instance_type          = "t2.micro"  # Specify your desired instance type
  key_name               = aws_key_pair.my_keypair.key_name
  security_groups        = [aws_security_group.my_security_group.name]
  associate_public_ip_address = true

  tags = {
    Name = "my-instance"
  }
}
