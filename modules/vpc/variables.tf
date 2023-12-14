variable "region" {
  type = string
  description = "this is the region where the vpc will be created"
}


variable "cidr_block" {
  type = string
  description = "this is the cidr block for the vpc"
}

variable "vpc_name" {
  type = string
  description = "this is the name of the vpc"
}

variable "public_subnet_cidr_block" {
  type = string
  description = "this is the cidr block for the public subnet"
}

variable "public_subnet_name" {
  type = string
  description = "this is the name of the public subnet"
}

variable "private_subnet_cidr_block" {
  type = string
  description = "this is the cidr block for the private subnet"
}

variable "private_subnet_name" {
  type = string
  description = "this is the name of the private subnet"
}

variable "availability_zone" {
  type = string
  description = "this is the availability zone for the subnet"
}

variable "igw_name" {
  type = string
  description = "this is the name of the internet gateway"
}

variable "public_route_table_name" {
  type = string
  description = "this is the name of the public route table"
}

variable "private_route_table_name" {
  type = string
  description = "this is the name of the private route table"
}



variable "nat_gateway_name"{
    type =string
    description ="this is the name of the nat gate way"
}