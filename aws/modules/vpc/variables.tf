variable "project" {}

variable "main_vpc_cidr_block" {}
variable "secondary_vpc_cidr_blocks" {}

variable "az_set" {}
variable "public_subnets" {}
variable "private_subnets" {}

variable "enable_natgw" {
  default = true
}

variable "vpc_endpoints" {
  default = {
    s3 = {
      service      = "s3"
      service_type = "Gateway"
    },
    ecr-api = {
      service = "ecr.api"
    },
    ecr-dkr = {
      service = "ecr.dkr"
    }
  }
}

variable "tags" {
  default = null
}