# Requirements

- Use the existing llama-server overlay install as a base
- It should auto spawn the server on nixos boot
- It shall use the model-file.ini config file for model configuration
- That file should be managed via nixos configuration, so if I change the model-file.ini in my nixos config, it should update on `nixos-rebuild`
- It shall be installed on the desktop system, and the framework system BUT NOT the thinkpad laptop
- On the desktop it should be built with cuda and vulkan
- On the framework laptop it should be built with vulkan only
- It shall listen on port 6000 on all interfaces with host localhost
- It shall use an API key for access control, this will come from the AI sops entry and should be provided via an environment variable to the container called `llama-cpp` in that file at the root level, it is not the only key in there but it is the only one we want to use right now.
- This shall be part of a larger "ai" module in my nixos configuration, so that I can enable/disable all ai related services at once.
- It shall be able to be disabled without modifying the nixos install. - It should be able to shutdown or start up. Maybe a systemd service?
- Use the default model switcher. Do not try to provide models to it.
- Let llama-server manage it's own model files
- Do make the model config machine specific. The one in the root right now should be the desktop one, just create a blank one for the framework laptop.
- Restart on crash automatically - let systemd handle this.
- Parllel 1 request only.

# Do not:
- Do not modify the overlay
- Do not use docker for deployment
- Do not install on the thinkpad laptop
- Do not worry about downloading the models, that is out of scope.


# Helpful links
https://github.com/ggml-org/llama.cpp/tree/master/tools/server - Contains the flags for llama cpp