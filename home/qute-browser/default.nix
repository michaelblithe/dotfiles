{pkgs, ...}: 

{
    programs.qutebrowser ={
        enable = true;

        settings = {
            content.blocking.method = "adblock";
          };
    };
}
