{ pkgs, ... }:

{
  # ZFS needs the default LTS kernel (override latest)
  boot.kernelPackages = pkgs.linuxPackages;
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
}
