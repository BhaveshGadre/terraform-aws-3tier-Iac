# Production 3-Tier AWS Infrastructure using Terraform

## Project Overview

This project demonstrates the provisioning of a highly available and scalable 3-tier architecture on AWS using Terraform. The infrastructure consists of a public web tier with an Application Load Balancer, a private application tier with Auto Scaling EC2 instances, and a private database tier powered by Amazon RDS MySQL.

Terraform remote state is securely stored in Amazon S3 with state locking enabled through DynamoDB, following industry best practices for Infrastructure as Code (IaC).

## Architecture Diagram

![Architecture](docs/architecture-diagram.png)

## Architecture

```text
Internet
    │
    ▼
Application Load Balancer
    │
    ▼
Auto Scaling Group
    │
    ▼
EC2 Instances (Private Subnets)
    │
    ▼
Amazon RDS MySQL
```

## AWS Services Used

- Amazon VPC
- Public, Private, and Database Subnets
- Internet Gateway & NAT Gateway
- Application Load Balancer (ALB)
- EC2 Auto Scaling Group
- Amazon RDS (MySQL)
- Amazon S3 (Terraform Backend)
- Amazon DynamoDB (State Locking)
- Security Groups

## Repository Structure

```text
.
├── docs/
├── screenshots/
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── network.tf
├── security.tf
├── loadbalancer.tf
├── compute.tf
├── database.tf
├── backend.tf
├── backend-bootstrap.tf
├── README.md
└── .gitignore
```

## Infrastructure Workflow

1. Terraform provisions the networking components.
2. Public and private subnets are created across multiple Availability Zones.
3. The ALB distributes traffic to EC2 instances in an Auto Scaling Group.
4. Private instances access the Internet through a NAT Gateway.
5. Amazon RDS is deployed in isolated database subnets.
6. Terraform state is stored remotely in S3 with DynamoDB locking.

## Features

- Infrastructure as Code with Terraform
- Highly Available 3-Tier Architecture
- Auto Scaling Web Tier
- Application Load Balancer
- Secure Database Tier
- Remote Terraform State Management
- Parameterized and Modular Configuration

## Project Screenshots

Add screenshots of:
- Terraform Apply Success
- AWS VPC Dashboard
- ALB and Target Group
- EC2 Auto Scaling Group
- RDS Instance
- S3 Backend and DynamoDB Lock Table

## Prerequisites

- AWS Account
- Terraform
- AWS CLI
- Git

## Key Learnings

- Terraform State Management
- AWS Networking Fundamentals
- High Availability Design
- Auto Scaling and Load Balancing
- Infrastructure Automation Best Practices

## Future Improvements

- Convert resources into reusable Terraform modules
- Add CI/CD for infrastructure deployment
- Integrate monitoring and alerting
- Support multiple environments (dev/stage/prod)

## Author

**Bhavesh Gadre**

Aspiring DevOps & Cloud Engineer

Focused on AWS, Terraform, Docker, Kubernetes, Jenkins, and Cloud Automation.