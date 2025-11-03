.PHONY: update private
update:
	git add .
	nh os switch .
private:
	git add .
	nh os switch '.?submodules=1'
