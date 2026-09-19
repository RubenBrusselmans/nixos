{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    completion.enable = true;
  };

  environment = {
    variables.EDITOR = "vim";
    shellAliases = {
      upgrade = "nix flake update --commit-lock-file --flake ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos";
      list-generations = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      collect-garbage = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };

    # https://github.com/NixOS/nixpkgs/issues/466765
    # https://github.com/NixOS/nixpkgs/issues/149812
    sessionVariables = {
      XDG_DATA_DIRS = [ "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}" ];
    };
  };

}
