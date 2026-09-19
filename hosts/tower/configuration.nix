{ ... }:

{
  networking.hostName = "tower";
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/shared
    ../../modules/server
    ../../users/ruben
    ../../users/gaming
    ../../users/camille
  ];
}
