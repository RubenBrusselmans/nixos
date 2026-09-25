{ pkgs, ... }:

{
  # ZFS needs the default LTS kernel (override latest)
  boot.kernelPackages = pkgs.linuxPackages;
  # Cap ARC at 12GiB
  boot.kernelParams = [ "zfs.zfs_arc_max=12884901888" ];
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs = {
    forceImportRoot = false;
    extraPools = [ "data" ];
    requestEncryptionCredentials = false;
  };

  # must match the hostid the pool was created with
  networking.hostId = "74092af9";

  services.zfs = {
    autoSnapshot = {
      enable = true;
      frequent = 4;
      daily = 7;
      hourly = 24;
      weekly = 4;
      monthly = 3;
    };
    autoScrub = {
      enable = true;
      pools = [ "data" ];
    };
  };

  # atime=off
  systemd.services.zfs-atime = {
    description = "Set atime=off on the data/crypt dataset";
    wantedBy = [ "multi-user.target" ];
    after = [ "zfs-import-data.service" ];
    requires = [ "zfs-import-data.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.zfs}/bin/zfs set atime=off data/crypt";
    };
  };
}
