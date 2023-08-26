module "vpc-peering-same-account-1-account2" {
  source           = "../../modules/vpc-peering/same-account"
  requestor_vpc_id = "ENTER VPC ID OF THE FIRST ACCOUNT HERE"
  acceptor_vpc_id  = "ENTER VPC ID OF THE SECOND ACCOUNT HERE"
  peer_region      = "ap-south-1"
}
