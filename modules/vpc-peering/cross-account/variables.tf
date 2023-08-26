terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.requestor, aws.acceptor]
    }
  }
}

variable "peer_region" {}
variable "requestor_vpc_id" {}
variable "acceptor_vpc_id" {}


data "aws_vpc" "requestor" {
  provider = aws.acceptor
  id       = var.acceptor_vpc_id
}

data "aws_route_tables" "requestor" {
  provider = aws.requestor
  vpc_id   = var.requestor_vpc_id
}

data "aws_vpc" "acceptor" {
  provider = aws.acceptor
  id       = var.acceptor_vpc_id
}

data "aws_route_tables" "acceptor" {
  provider = aws.acceptor
  vpc_id   = var.acceptor_vpc_id
}

data "aws_caller_identity" "peer" {
  provider = aws.acceptor
}