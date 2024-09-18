provider "aws" {
  region = "us-east-1"  
}

resource "aws_vpc" "My_Terraform_vpc_web_app" {  
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Terraform_vpc"
    "Terraform-Web-Application" = "true"
    Builder                 = "Difeozo" 
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.My_Terraform_vpc_web_app.id  
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"  
  tags = {
    Name = "Terraform_public_subnet"
    "Terraform-Web-Application" = "true"
    Builder                 = "Difeozo" 
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.My_Terraform_vpc_web_app.id  
  cidr_block = "10.0.2.0/24"
  availability_zone       = "us-east-1b"  
  tags = {
    Name = "Terraform_private_subnet"
    "Terraform-Web-Application" = "true"
    Builder                 = "Difeozo" 
  }
}

# Create an Internet Gateway to allow outbound internet access for the VPC
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.My_Terraform_vpc_web_app.id

  tags = {
    Name = "Terraform_internet_gateway"
    Builder                 = "Difeozo" 
  }
}

# Create a route table for the public subnet to route traffic to the Internet Gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.My_Terraform_vpc_web_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Terraform_public_route_table"
    Builder                 = "Difeozo" 
  }
}

# Associate the public subnet with the route table
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}