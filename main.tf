terraform {
  # Define required providers and their versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.32.0"
    }
  }
}

# AWS Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# VPC Creation
resource "aws_vpc" "VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My-vpc"
  }
}

# Subnet Creation
resource "aws_subnet" "Subnet" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = "10.0.1.0/18"

  tags = {
    Name = "My-subnet"
  }
}

# Route Table Creation
resource "aws_route_table" "RouteTable" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "My-route-table"
  }
}

# Route Table Association
resource "aws_route_table_association" "RouteTableAssociation" {
  subnet_id      = aws_subnet.Subnet.id
  route_table_id = aws_route_table.RouteTable.id
}