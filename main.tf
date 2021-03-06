#Author: Keegan Flood
#Purpose: Coalfire Technical Challenge
#Date: 23 November 2021

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region
}


#-------------Networking Module--------------

module "network_provision" {
  source   = ".//modules/Networking"
  vpc_cidr = "10.1.0.0/16"
}


#-------------Compute Module--------------

module "compute_provision" {
  source                   = ".//modules/Compute"
  key_name                 = "coalfire_key"
  vpc_id                   = module.network_provision.vpc_id
  public_subnet_id_list    = module.network_provision.public_subnet_id_list
  private_subnet_id_list   = module.network_provision.private_subnet_id_list
  security_group_id        = module.network_provision.security_group_id

}

#-------------S3 Module------------------

module "S3_provision" {
  source      = ".//modules/S3"
}
