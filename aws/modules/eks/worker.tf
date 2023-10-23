# worker group
resource "aws_eks_node_group" "worker-node" {
  cluster_name    = aws_eks_cluster.master.name
  node_group_name = "worker-nodes"
  version         = var.eks_version
  instance_types  = var.instance_types
  disk_size       = var.disk_size

  node_role_arn = aws_iam_role.node.arn
  subnet_ids    = var.eks_subnet_ids

  scaling_config {
    desired_size = var.node_count
    max_size     = coalesce(var.max_node_count, (2 * var.node_count) - 1)
    min_size     = coalesce(var.min_node_count, 1)
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node-CloudWatchAgentServerPolicy,
    aws_iam_role_policy.s3_access_policy,
  ]
}

resource "aws_eks_node_group" "worker-spot" {
  count = var.enable_spot_pool ? 1 : 0

  cluster_name    = aws_eks_cluster.master.name
  node_group_name = "worker-nodes-spot"
  capacity_type   = "SPOT"
  version         = var.eks_version
  instance_types  = var.spot_instance_types
  disk_size       = var.disk_size

  node_role_arn = aws_iam_role.node.arn
  subnet_ids    = var.eks_subnet_ids

  scaling_config {
    desired_size = var.spot_node_count
    max_size     = (var.spot_node_count * 2) - 1
    min_size     = 1
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.node-CloudWatchAgentServerPolicy,
    aws_iam_role_policy.s3_access_policy,
  ]
}