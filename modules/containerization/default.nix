{ pkgs, inputs, ... }:


{
  virtualisation.docker.enable = true;
  virtualisation.containers.registries.search = [ "docker.io" ];
  virtualisation.podman.enable = true;
}
