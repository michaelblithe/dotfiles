{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      azahar = {
        executable = "${pkgs.azahar}/bin/azahar-room";
        profile = pkgs.writeText "azahar.profile" ''
          # Firejail profile for Azahar 3DS emulator
          include /etc/firejail/disable-common.inc
          include /etc/firejail/disable-devel.inc
          include /etc/firejail/disable-interpreters.inc
          include /etc/firejail/disable-programs.inc

          # Allow access to home directory for ROMs and save files
          whitelist ''${HOME}/roms
          whitelist ''${HOME}/.local/share/azahar
          whitelist ''${HOME}/.config/azahar
          whitelist ''${HOME}/.cache/azahar

          # Graphics support (needed for emulator rendering)
          noblacklist ''${HOME}/.local/share/vulkan
          include /etc/firejail/whitelist-var-common.inc

          # No network access
          net none
          protocol unix

          # System access
          caps.drop all
          nonewprivs
          noroot

          # Allow OpenGL/Vulkan for rendering
          noblacklist /dev/dri
          noblacklist /dev/nvidia*

          # Audio support
          noblacklist /dev/snd

          # Misc hardening
          shell none
          disable-mnt
          private-dev
        '';
      };
      mgba = {
        executable = "${pkgs.mgba}/bin/mgba";
        profile = pkgs.writeText "mgba.profile" ''
          # Firejail profile for mGBA emulator
          include /etc/firejail/disable-common.inc
          include /etc/firejail/disable-devel.inc
          include /etc/firejail/disable-interpreters.inc
          include /etc/firejail/disable-programs.inc

          # Allow access to home directory for ROMs and save files
          whitelist ''${HOME}/roms
          whitelist ''${HOME}/.local/share/mgba
          whitelist ''${HOME}/.config/mgba
          whitelist ''${HOME}/.cache/mgba

          # Graphics support (needed for emulator rendering)
          noblacklist ''${HOME}/.local/share/vulkan
          include /etc/firejail/whitelist-var-common.inc

          # No network access
          net none
          protocol unix

          # System access
          caps.drop all
          nonewprivs
          noroot

          # Allow OpenGL/Vulkan for rendering
          noblacklist /dev/dri
          noblacklist /dev/nvidia*

          # Audio support
          noblacklist /dev/snd

          # Misc hardening
          shell none
          disable-mnt
          private-dev
        '';
      };
    };
  };
}
