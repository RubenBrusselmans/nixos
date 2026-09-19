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

  programs.umbriel = {
    enable = true;
    package = pkgs.unstable.umbriel;
    portalPackage = pkgs.unstable.xdg-desktop-portal-umbriel;
  };

  programs.noctalia = {
    enable = true;
    package = pkgs.unstable.noctalia;
    systemd.enable = true;
    recommendedServices.enable = true;
  };
}
