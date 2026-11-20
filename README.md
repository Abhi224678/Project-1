# Capstone Project

## Project 1: Deploy a Linux EC2 Web Server Using Terraform

I performed the following activities to deploy an Apache web server on AWS EC2 using Terraform:
1. I configured the AWS provider and selected the Mumbai region (`ap-south-1`).
2. I identified the Ubuntu 22.04 LTS AMI using the Terraform AWS AMI data source.
3. I referenced the existing default VPC and public subnet using Terraform data sources.
4. I created a dedicated security group and configured inbound HTTP traffic on TCP port 80 from `0.0.0.0/0`, along with outbound traffic rules.
5. I configured an EC2 instance using the Ubuntu 22.04 LTS AMI and selected the `t2.micro` instance type.
6. I associated the EC2 instance with the existing public subnet and the newly created security group.
7. I configured EC2 User Data to automate package updates, Apache2 installation, service activation, and creation of a custom HTML webpage.
8. I initialized the Terraform working directory using `terraform init`.
9. I formatted and validated the Terraform configuration using `terraform fmt` and `terraform validate`.
10. I generated and reviewed the infrastructure execution plan using `terraform plan`.
11. I deployed the AWS infrastructure using `terraform apply`.
12. I retrieved the EC2 instance ID, public IP address, and website URL from the Terraform outputs.
13. I accessed the public IP address through a web browser to verify the Apache web server and hosted webpage.

## Deployment Details

| Parameter | Value |
|---|---|
| AWS Region | ap-south-1 |
| Instance ID | i-0ea2c9a4749f6671e |
| Instance Type | t2.micro |
| Operating System | Ubuntu 22.04 LTS |
| Web Server | Apache2 |
| Public IP | 13.201.21.200 |
| Website URL | http://13.201.21.200 |

## Deployment Result

- Security Group: Successfully created
- EC2 Instance: Successfully created
- Apache Web Server: Configured through User Data
- Terraform Resources: 2 added, 0 changed, 0 destroyed
  
