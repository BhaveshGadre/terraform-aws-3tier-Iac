variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR for Public Subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "CIDR for Public Subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "az_a" {
  description = "Availability Zone A"
  type        = string
  default     = "us-east-1a"
}

variable "az_b" {
  description = "Availability Zone B"
  type        = string
  default     = "us-east-1b"
}

variable "private_subnet_a_cidr" {
  description = "CIDR for Private App Subnet A"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR for Private App Subnet B"
  type        = string
  default     = "10.0.4.0/24"
}

variable "db_subnet_a_cidr" {
  description = "CIDR for Database Subnet A"
  type        = string
  default     = "10.0.5.0/24"
}

variable "db_subnet_b_cidr" {
  description = "CIDR for Database Subnet B"
  type        = string
  default     = "10.0.6.0/24"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0b6d9d3d33ba97d99"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.small"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "project-key"
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 2
}
variable "db_instance_class" {
  description = "RDS Instance Class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "RDS Storage in GB"
  type        = number
  default     = 20
}














variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}