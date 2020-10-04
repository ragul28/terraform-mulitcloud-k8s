plan:
	cd $(provider)
	terraform fmt
	terraform init
	terraform plan

planout:
	cd $(provider)
	terraform plan -out=out.plan

apply:
	cd $(provider)
	terraform apply out.plan
