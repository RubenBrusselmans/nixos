{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/wayland/umbriel.nix"
    "${inputs.nixpkgs-unstable}/nixos/modules/programs/wayland/noctalia.nix"
  ];

  environment.systemPackages = with pkgs; [
    playerctl
  ];

  programs.umbriel = {
    enable = true;
    package = pkgs.unstable.umbriel;
    portalPackage = pkgs.unstable.xdg-desktop-portal-umbriel;
  };

  programs.noctalia = {
    enable = true;
    package = pkgs.unstable.noctalia;
    systemd.enable = true;
    systemd.target = "umbriel-session.target";
    recommendedServices.enable = true;
  };
}
