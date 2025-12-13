.PHONY: update private wsl
update:
	git add .
	nh os switch .
private:
	git add .
	nh os switch '.?submodules=1'
wsl:
	git add .
	nh os boot .
wsltar:
	git add .
	sudo nix run .#nixosConfigurations.SolOS-WSL.config.system.build.tarballBuilder
