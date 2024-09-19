Project Description:
"Setting Up AWS Infrastructure for a Web Application using Terraform"

                           +---------------------------------+
                           |           Internet              |
                           +---------------------------------+
                                   |
                                   |
                        +---------------------------+
                        |   Application Load Balancer |
                        +---------------------------+
                                   |
                                   |
                +------------------+------------------+
                |                                     |
     +-----------------------+              +-----------------------+
     |    Public Subnet 1    |              |    Public Subnet 2    |
     +-----------------------+              +-----------------------+
                |                                     |
     +-----------------------+              +-----------------------+
     |      EC2 Instance     |              |      EC2 Instance     |
     +-----------------------+              +-----------------------+
                |                                     |
                +---------------------------+ 
                |    Private Subnet          |
                +---------------------------+
                |    RDS (MySQL Database)   |
                +---------------------------+


This project uses Terraform to automate the provisioning of AWS resources for a web application. It includes the following components:

VPC: A custom Virtual Private Cloud with public and private subnets.
Security Groups: Rules allowing HTTP, SSH, and MySQL traffic.
EC2 Instance: A web server running on Amazon Linux 2 with a security group allowing access over HTTP and SSH.
Key Pair: Used for SSH access to the EC2 instance.
Key Terraform Files:
vpc.tf: Defines the custom VPC, public and private subnets.

Updates: map_public_ip_on_launch = true to enable public IP for the EC2 instance.
security_group.tf: Defines two security groups:

One for web traffic (HTTP, SSH).
One for database traffic (MySQL), linked to the web security group.
ec2.tf: Defines the EC2 instance, which is deployed in the public subnet with security rules and metadata options.

Updates: key_name and metadata_options to improve security and SSH access.
Next Steps:
Set Up RDS (Database):

Use aws_db_instance to provision a MySQL database in a private subnet.
Ensure connection security between the web instance and database using security groups.
Route Table & Internet Gateway:

Add a route table for public internet access and an internet gateway in a separate file.
Documentation: You can organize your project documentation by explaining each resource and its purpose in the AWS architecture:

VPC: Networking backbone for isolating and managing subnets.
Security Groups: Manage network traffic permissions.
EC2: Web server hosting a simple HTTP site.
RDS (when added): Backend database for the application.
