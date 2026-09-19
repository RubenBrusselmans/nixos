{ config, lib, ... }:

{
  options.users.ruben.fullHome = lib.mkEnableOption "the full home-manager config for ruben";

  config = {
    users.users.ruben = {
      isNormalUser = true;
      description = "Ruben";
      # NixOS drops groups undefined on a host, so no mkIf logic required
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "podman"
        "gamemode"
        "k3s"
      ];
      openssh.authorizedKeys.keyFiles = [ ./keys/ruben.pub ];
    };

    home-manager.users.ruben = lib.mkIf config.users.ruben.fullHome (import ./home);
  };
}
