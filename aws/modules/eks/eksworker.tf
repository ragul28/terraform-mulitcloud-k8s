# worker group
resource "aws_eks_node_group" "worker-node" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "worker-nodes"
  release_version = var.k8s_version
  instance_types  = var.instance_types 
  disk_size       = var.disk_size
  
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.eks_subnet_ids

  scaling_config {
    desired_size = var.node_count
    max_size     = var.node_count
    min_size     = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node-CloudWatchAgentServerPolicy,
    aws_iam_role_policy.s3_access_policy,
  ]
}

resource "aws_eks_node_group" "worker-node-spot" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "worker-nodes-spot"
  capacity_type   = "SPOT"
  release_version = var.k8s_version
  instance_types  = var.spot_instance_types
  disk_size       = var.disk_size
  
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.eks_subnet_ids

  scaling_config {
    desired_size = var.spot_node_count
    max_size     = (var.spot_node_count * 2) - 1 
    min_size     = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node-CloudWatchAgentServerPolicy,
    aws_iam_role_policy.s3_access_policy,
  ]
}