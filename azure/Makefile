validate:
	terraform fmt
	terraform init --upgrade
	terraform validate 
	
plan:
	terraform plan

auto_apply:
	terraform apply -auto-approve

planout:
	terraform plan -out=out.plan

apply:
	terraform apply out.plan

infracost: planout
	infracost breakdown --path=out.plan