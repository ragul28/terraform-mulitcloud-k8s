#EKS
resource "aws_eks_cluster" "master" {
  name     = var.project
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.eks_version

  vpc_config {

    subnet_ids              = var.eks_subnet_ids
    security_group_ids      = [aws_security_group.eks_cluster.id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSVPCResourceController,
  ]
}