# Multi cloud k8s provisioning using terraform   

Provision k8s cluster in all there major cloud providers using single terraform repository.

* AWS EKS 
* Azure AKS
* GCP GKE

## Usage

### EKS

* Make sure AWS credentials are configured using aws-cli.
* Fill with necessary variables in `terraform.tfvars` file.
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

* To estimate cost using infracost.
    ```sh
    make infracost
    ```

### AKS

* Authenticating azure provider using the Azure CLI
    ```
    az login
    az account set --subscription="SUBSCRIPTION_ID"
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

### GKE

* Install gcloud cli & auth with gcp account
* Add your account to the app default credentials. 
    ```
    gcloud auth application-default login
    ```
* Update the tfvars file & init terrform. To enable regonal cluster comment zone in `terraform.tfvars`.  
    ```
    cd gcp
    cp terraform.tfvars.sample terraform.tfvars
    terraform init
    terraform apply
    ```