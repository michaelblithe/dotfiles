{
  disko.devices = {
    disk.main = {
      device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_1TB_S5H9NC0MB03685J";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = { size = "1M"; type = "EF02"; };
          ESP = {
            size = "1G";
            type = "EF00";
            content = { type = "filesystem"; format = "vfat"; mountpoint = "/boot"; };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };
    lvm_vg.pool = {
      type = "lvm_vg";
      lvs = {
        swap = {
          size = "8G";
          content = { type = "swap"; };
        };
        root = {
          size = "100%FREE";
          content = { type = "filesystem"; format = "ext4"; mountpoint = "/"; };
        };
      };
    };
  };
}