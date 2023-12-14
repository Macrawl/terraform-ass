resource "aws_security_group" "public-security-group" {
  name        = var.public_security_group_name
  description = "Allow ssh, http and https inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow ssh inbound traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = "41.58.240.33/32"
  }

  ingress {
    description      = "Allow http inbound traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = "0.0.0.0/0"
  }

  ingress {
    description      = "Allow https inbound traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = "0.0.0.0/0"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_security_group_name
  }
}

resource "aws_security_group" "private-security-group" {
  name        = var.private_security_group_name
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow ssh inbound traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = aws_subnet.public_subnet.cidr_block
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = "0.0.0.0/0"
  }
}