{ ... }:

{
  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        "framework" = {
          id = "X5AOQJ6-KKA3U5T-RG2W42D-7GO7OXV-L5EJSAZ-7VNHCMU-PICR53B-Y36AZAL";
        };
        "macbook" = {
          id = "ABXUGLL-TWN22MF-ZNHL3TW-HZ7JH47-PA4GIEF-FZX3MV2-E4L5XNC-N6FR4A6";
        };
        "desktop" = {
          id = "3HGNBT7-T35ALSL-TSTEVOL-77IHHNB-44G7GU7-UPADBA3-J2TFXYN-2WWHOQF";
        };
        "luna" = {
          id = "DNWN7TQ-74ZA7R7-Z4JYJUU-7SDIGLY-FBY4A4K-YZFBXC7-FXUBPUG-5MR6AAQ";
        };
        "iphone" = {
          id = "X3JAU7A-7VLYXVQ-VG7ZBVV-Q2MGYRR-VIFWJXD-MERQSYC-W36NSKQ-VUKVGAR";
        };
      };
      folders = {
        "notes" = {
          path = "/home/alex/notes";
          devices = [
            "framework"
            "macbook"
            "desktop"
            "luna"
            "iphone"
          ];
        };
        "games" = {
          path = "/home/alex/games";
          devices = [
            "framework"
            "macbook"
            "desktop"
            "luna"
            "iphone"
          ];
        };
        "c7bzt-7ejmj" = {
          label = "sync";
          path = "/home/alex/sync";
          devices = [
            "framework"
            "macbook"
            "desktop"
            "luna"
            "iphone"
          ];
        };
      };
    };
  };
}
