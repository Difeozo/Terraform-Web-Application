resource "aws_security_group" "Terraform_web_sg" {  
  name        = "Terraform_web_sg"  
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.My_Terraform_vpc_web_app.id  

  ingress {
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

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

  tags = {
    Name = "Terraform_web_sg"  
    "Terraform-Web-Application" = "true" 
    Builder                 = "Difeozo" 
  }
}

resource "aws_security_group" "Terraform_db_sg" {  
  name        = "Terraform_db_sg"  
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.My_Terraform_vpc_web_app.id  

  ingress {
    from_port   = 3306  
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.Terraform_web_sg.id]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform_db_sg"
    "Terraform-Web-Application" = "true"
    Builder                 = "Difeozo" 
  }
}
