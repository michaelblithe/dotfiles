{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  
  home.packages = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "pixel-operator";
      src = ../../fonts/pixel_operator;
      
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp *.ttf $out/share/fonts/truetype/
      '';
    })
  ];
}
