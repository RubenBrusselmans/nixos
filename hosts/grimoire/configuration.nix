{ ... }:
{
  networking.hostName = "grimoire";
  system.stateVersion = "25.11";

  users.ruben.fullHome = true;

  imports = [
    ./hardware-configuration.nix
    ../../modules/shared
    ../../modules/laptop
    ../../users/ruben
  ];
}
