provider "aws" {
  region = var.region
}

#To generate the pem file
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


#Create the public key that will be used to access AWS
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

#private key that will be saved in the local machine in order to authenticate the public key before ssh into aws

resource "local_file" "private_key" {
    content = tls_private_key.rsa_4096.private_key_pem
    filename = var.key_name           
}

data "aws_ami" "free_tier" {
  most_recent = true
  owners = ["self"]
}

resource "aws_instance" "private instance" {
  ami = data.aws_ami.free_tier.id
  key_name = var.key_name
  subnet_id = aws_subnet.private_subnet.id
  user_data = file("${path.module}/script.sh")


  tags ={
    name = "private_instance"
  }
}

resource "aws_instance" "public_instance" {
  ami                 = data.aws_ami.free_tier.id
  key_name             = var.key_name
  subnet_id            = aws_subnet.public_subnet.id
  user_data            = file("${path.module}/script.sh")

  tags                 = {
    Name                = "public_instance"
  }
}



