{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    htop
    rsync
    screen
    tree
    killall
    dig
    jq
    openssl
    lm_sensors
    pciutils
  ];
}
