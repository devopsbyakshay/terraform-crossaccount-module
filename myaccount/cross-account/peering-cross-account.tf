module "vpc-peering-cross-account-1-account2" {
  source           = "../../modules/vpc-peering/cross-account"
  requestor_vpc_id = "ENTER VPC ID OF THE FIRST ACCOUNT HERE"
  acceptor_vpc_id  = "ENTER VPC ID OF THE SECOND ACCOUNT HERE"
  peer_region      = "ap-south-1"
  providers        = {
    aws.requestor = aws
    aws.acceptor  = aws.my-second-account
  }
}
