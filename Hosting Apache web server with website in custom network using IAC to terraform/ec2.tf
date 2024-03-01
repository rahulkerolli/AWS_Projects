resource "aws_instance" "web_server" {
  ami           = "ami-09538990a0c4fe9be"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.ssh_access.id
  ]

  user_data = file("user_data.sh")

  tags = {
    Name = "Terraform-instance"
  }
}

resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh_access"
  vpc_id      = aws_vpc.main.id

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
}

resource "aws_eip" "eip" {
  instance = aws_instance.web_server.id

  tags = {
    Name = "test-eip"
  }
}
