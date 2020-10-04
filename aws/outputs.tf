# output "config_map_aws_auth" {
#   value = module.aws-eks.config_map_aws_auth
# }

# output "kubeconfig" {
#   value = module.aws-eks.kubeconfig
# }

output "vpc_id" {
  value = module.aws-vpc.vpc_id
}

output "subnet_ids" {
  value = module.aws-vpc.subnet_ids
}