validate:
	$(MAKE) -C $(provider) 
	
plan:
	$(MAKE) -C $(provider)

planout:
	$(MAKE) -C $(provider) 

apply:
	$(MAKE) -C $(provider) 