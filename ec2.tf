resource "aws_instance" "web_instance" {
  ami                    = "ami-06f555bf2f102b63c"  
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id  
  vpc_security_group_ids = [aws_security_group.Terraform_web_sg.id]  
  key_name               = "Class-Demo"  

  metadata_options {
    http_tokens = "required"  
    http_endpoint = "enabled"  
  }

  tags = {
    Name                    = "Terraform_WebInstance"
    "Terraform-Web-Application" = "true" 
    Builder                 = "Difeozo"  
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo systemctl start httpd
                sudo systemctl enable httpd
                echo "<h1>Welcome to the Web Server</h1>" > /var/www/html/index.html
                EOF
}