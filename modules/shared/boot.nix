{
  config,
  pkgs,
  lib,
  ...
}:
let
  # derive luks volumes from hardware-configuration.nix
  luksMappers = lib.unique (
    map (fs: lib.removePrefix "/dev/mapper/" fs.device) (
      lib.filter (fs: lib.hasPrefix "/dev/mapper/luks-" fs.device) (lib.attrValues config.fileSystems)
    )
    ++ map (sw: lib.removePrefix "/dev/mapper/" sw.device) (
      lib.filter (sw: lib.hasPrefix "/dev/mapper/luks-" sw.device) config.swapDevices
    )
  );
in
{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    consoleLogLevel = 2;
    kernelParams = [
      "quiet"
      "splash"
    ];

    # initrd entry per volume + allow ssd trim
    initrd.luks.devices = lib.listToAttrs (
      map (mapper: {
        name = mapper;
        value = {
          device = lib.mkDefault "/dev/disk/by-uuid/${lib.removePrefix "luks-" mapper}";
          allowDiscards = true;
        };
      }) luksMappers
    );

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "dragon";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "dragon" ];
        })
      ];
    };
  };
}
