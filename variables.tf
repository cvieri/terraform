variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "env" {
  type    = string
  default = "prod"
}

variable "eks_cluster_version" {
  default = "1.28"
}

variable "vpc_cidr" {
  type    = string
  default = "10.147.0.0/18"
}

variable "vpc_private_subnets" {
  type    = list(any)
  default = ["10.147.4.0/22", "10.147.8.0/22", "10.147.12.0/22", "10.147.16.0/22"]
}

variable "vpc_public_subnets" {
  type    = list(any)
  default = ["10.147.20.0/23", "10.147.22.0/23", "10.147.24.0/23", "10.147.26.0/23"]
}

variable "default_tags" {
  default = {
    "environment" = "prod"
  }
}
