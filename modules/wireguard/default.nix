{
  config,
  pkgs,
  ...
}:

{
  sops.secrets.wireguard-privatekey = {
    sopsFile = ../../secrets/wireguard.yaml;
  };

  networking.wg-quick.interfaces.wg0 = {
    privateKeyFile = config.sops.secrets.wireguard-privatekey.path;
    address = [ "10.2.0.2/32" ];
    dns = [ "10.2.0.1" ];

    peers = [
      {
        # publicKey = "eAXSF+LlakN4YOXCSTO/C+FHrwxISh/ekH+BuSjLZgY=";
        # allowedIPs = [ "0.0.0.0/0" "::/0" ];
        # endpoint = "151.243.141.6:51820";
        publicKey = "umCaW98SBPbNjApBKCo0ReYhT2AJ0QfV/ZlyWnWmVUk=";
        allowedIPs = [ "0.0.0.0/0" "::/0" ];
        endpoint = "149.102.226.225:51820";
        persistentKeepalive = 25;
      }
    ];
  };

}
