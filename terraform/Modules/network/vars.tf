
variable "vpc_cidr" {
    default = "10.1.0.0/22"
}

variable "pub-subnets" {
    default = ["10.1.0.0/24","10.1.1.0/24"]
}

variable "priv-subnets" {
    default = ["10.1.2.0/24","10.1.3.0/24"]
}

### AWS deafult VPC id
variable "default-vpc-cidr" {
    default = "vpc-49101621"
}

### AWS default VPC IPv4 CIDR
variable "IPv4-CIDR" {
    default = "172.31.0.0/16"
}

### AWS default VPC Route table
variable "default-vpc-rt" {
    default = "rtb-765c931d"
}
variable "az-single-char" {
    default = ["A","B","C","D","E","F"]
}

data "aws_availability_zones" "az" {}
data "aws_caller_identity" "peer" {}



### Variables inherited from MAIN
variable "proj" {}
variable "application" {}
