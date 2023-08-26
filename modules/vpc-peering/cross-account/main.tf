# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  peer_owner_id = data.aws_caller_identity.peer.account_id
  peer_region   = var.peer_region
  vpc_id        = var.requestor_vpc_id
  peer_vpc_id   = var.acceptor_vpc_id
  auto_accept   = false
  provider      = aws.requestor
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true
  provider                  = aws.acceptor
}

#Module      : ROUTE REQUESTOR
#Description : Create routes from requestor to acceptor.
resource "aws_route" "requestor_vpc_peering" {
  count                     = length(data.aws_route_tables.requestor.ids)
  route_table_id            = tolist(data.aws_route_tables.requestor.ids)[count.index]
  destination_cidr_block    = data.aws_vpc.acceptor.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  provider                  = aws.requestor
}

#Module      : ROUTE ACCEPTOR
#Description : Create routes from acceptor to requestor.
resource "aws_route" "acceptor_vpc_peering" {
  count                     = length(data.aws_route_tables.acceptor.ids)
  route_table_id            = tolist(data.aws_route_tables.acceptor.ids)[count.index]
  destination_cidr_block    = data.aws_vpc.requestor.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  provider                  = aws.acceptor
}
