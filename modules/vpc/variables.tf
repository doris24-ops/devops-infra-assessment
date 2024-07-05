variable "project_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}


variable "public_subnet_cidr_blocks" {
  type = list(string)
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
}

variable "aws_region" {

  type = string

}
variable "environment_name" {

  type = string

}
variable "cluster_name" {
  type = string
}