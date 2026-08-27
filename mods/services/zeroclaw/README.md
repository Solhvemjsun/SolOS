# Initialization:
```console
$ sudo systemctl stop zeroclaw # Stop the auto restart progress first

$ sudo su zeroclaw # Switch to the corresponding bot account

$ nix-shell -p zeroclaw # Add the package in shell environment

$ zeroclaw onboard # Initialize the config for zeroclaw
```

# After Initialization
```console
$ sudo systemctl start zeroclaw # Restore the zeroclaw daemon service
```
