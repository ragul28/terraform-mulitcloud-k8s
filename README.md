# Multi cloud k8s provisioning using terraform   

Provision k8s cluster in all there major cloud providers using single terraform repository.

* AWS EKS 
* Azure AKS
* GCP GKS 

## Usage

### EKS

* Run the terraform with necessary variables.
```
cd aws/
terraform init
terraform apply
```

* To append kubeconfig file default path
```
aws eks update-kubeconfig --name <CLUSTER_NAME>
```

### AKS

* Create Service principal for Subscription
    ```
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<Subscription-ID>"
    ```

* Clone project & fill the terraform variables in `terraform.tfvars`.
    ```
    cd azure/
    cp terraform.tfvars.sample terraform.tfvars
    terraform init
    terraform apply
    ```
    
* Get kubeconfig using az or export
    ```
    az aks get-credentials --resource-group saiv-staging-rg --name saiv-staging
    ```
    or
    ```
    echo "$(terraform output kube_config)" > az-kube-confg.yml
    export KUBECONFIG="$PWD/az-kube-confg.yml"
    ```