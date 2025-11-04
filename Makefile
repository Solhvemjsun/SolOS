.PHONY: update private wsl
update:
	git add .
	nh os switch .
private:
	git add .
	nh os switch '.?submodules=1'
wsl:
	git add .
	sudo nixos-rebuild boot --flake .
