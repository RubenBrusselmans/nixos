{ ... }:
{
  home.username = "ruben";
  home.homeDirectory = "/home/ruben";
  home.stateVersion = "25.11";

  imports = [
    ./packages.nix
    ./flameshot.nix
    ./firefox.nix
    ./dconf.nix
    ./xdg.nix
    ./vscodium.nix
    ./ansible.nix
    ./ghostty.nix
    ./neovim.nix
    ./fonts.nix
  ];
}
