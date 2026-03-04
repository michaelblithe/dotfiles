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
      };
      folders = {
        "notes" = {
          path = "/home/alex/notes";
          devices = [
            "framework"
            "macbook"
            "desktop"
          ];
        };
        "games" = {
          path = "/home/alex/games";
          devices = [
            "framework"
            "macbook"
            "desktop"
          ];
        };
        "c7bzt-7ejmj" = {
          label = "sync";
          path = "/home/alex/sync";
          devices = [
            "framework"
            "macbook"
            "desktop"
          ];
        };
      };
    };
  };
}
