.PHONY: update
update:
	git add .
	nh os switch '.?submodules=1' 
