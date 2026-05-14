# Summary
As a user, I want to use the lite-llm proxy on my nixos system.


# Requirements
- Nixos deployment
- Use docker container for deployment
- Use the lite-llm proxy for local LLM inference
- Uses postgres for database
- Put it all in a nixos module I can shutdown and start up with ease
- All of it should be configured via a yaml file
- For secrets, they should come from sops. Using NixOs' sops.
- The DB should be persisted to the local filesystem, so that it can be easily backed up and restored.
- This is a single user deployment.
- At first we just want to support google vertex ai as the provider

# Helpful links