{
  config,
  ...
}:

let
  commonConfig = {
    privateKeyFile = config.sops.secrets.wireguard-privatekey.path;
    address = [ "10.2.0.2/32" ];
    dns = [ "10.2.0.1" ];
  };
in

{
  sops.secrets.wireguard-privatekey = {
    sopsFile = ../../secrets/wireguard.yaml;
  };

  networking.wg-quick.interfaces.wg0 = commonConfig // {
    peers = [
      {
        publicKey = "eAXSF+LlakN4YOXCSTO/C+FHrwxISh/ekH+BuSjLZgY=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "151.243.141.6:51820";
        persistentKeepalive = 25;
      }
    ];
  };

  networking.wg-quick.interfaces.wg1 = commonConfig // {
    peers = [
      {
        publicKey = "umCaW98SBPbNjApBKCo0ReYhT2AJ0QfV/ZlyWnWmVUk=";
        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
        endpoint = "149.102.226.225:51820";
        persistentKeepalive = 25;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools
    protonvpn-gui
  ];

    # Needed for proton VPN to work properly
  networking.firewall.checkReversePath = false;

  # Allow local subnet access while VPN is active
  networking.localCommands = ''
    ip route add 192.168.1.0/24 dev $(ip route | grep 'default' | grep -v 'tun' | awk '{print $5}' | head -1) metric 50 || true
  '';

}
