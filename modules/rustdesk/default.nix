{
  services.rustdesk-server = {
    enable = true;
    openFirewall = false;
    signal.relayHosts = [ "127.0.0.1" ];
  };

  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPorts = [ 21115 21116 21117 21118 21119 ];
    allowedUDPPorts = [ 21116 ];
  };
}
