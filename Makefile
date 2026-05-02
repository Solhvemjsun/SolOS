.PHONY: boot update private wsl wsltar
boot:
	git add .
	nh os boot .
update:
	git add .
	nh os switch .
private:
	git add .
	nh os boot '.?submodules=1'
wsltar:
	git add .
	sudo nix run .#nixosConfigurations.SolOS-WSL.config.system.build.tarballBuilder
nod:
	git add .
	nix-on-droid wsitch --flake .
