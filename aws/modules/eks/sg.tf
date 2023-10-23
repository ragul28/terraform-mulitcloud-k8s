resource "aws_security_group" "eks_cluster" {
  name        = "${var.project}-eks-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.eks_vpc_id
}

resource "aws_security_group_rule" "eks-cluster-api" {
  security_group_id = aws_security_group.eks_cluster.id
  description       = "Allow cluster API Server access"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}