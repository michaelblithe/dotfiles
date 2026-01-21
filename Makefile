.PHONY: build-thinkpad

build-thinkpad:
	rm -rf result
	rm thinkpad.qcow2 || true
	nix build .#nixosConfigurations.thinkpad.config.system.build.vm
