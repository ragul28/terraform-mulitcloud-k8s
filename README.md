# Multi cloud k8s provisioning using terraform   

Provision k8s cluster in all there major cloud providers using single terraform repository.

* EKS 
* AKS
* GKS 

## Usage

### EKS

* Run the terraform with necessary variables.
```
terraform apply
```

* To append kubeconfig file default path
```
aws eks update-kubeconfig --name <CLUSTER_NAME>
```

### AKS
