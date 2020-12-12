validate:
	terraform fmt
	terraform init
	terraform validate 
	
plan:
	terraform plan

auto_apply:
	terraform apply -auto-approve

planout:
	terraform plan -out=out.plan

apply:
	terraform apply out.plan

auto_destory:
	terraform destroy -auto-approve

destory_t:
	terraform destroy -target $(target)

infracost: planout
	infracost --tfdir . --tfplan out.plan