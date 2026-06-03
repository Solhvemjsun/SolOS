.PHONY: update boot private wsl wsltar
update:
	git add .
	nh os switch .
boot:
	git add .
	nh os boot .
private:
	git add .
	nh os boot '.?submodules=1'
wsltar:
	git add .
	sudo nix run .#nixosConfigurations.SolOS-WSL.config.system.build.tarballBuilder
nod:
	git add .
	nix-on-droid switch --flake .
server:
	git pull
	git submodule sync --recursive
	git submodule update --init --recursive
	nh os boot '.?submodules=1'
