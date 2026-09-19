{ pkgs, ... }:
{
  services.xserver.enable = false;

  services.displayManager.gdm.enable = true;

  services.desktopManager.gnome.enable = true;

  services.gnome = {
    core-apps.enable = true;
    core-developer-tools.enable = false;
    games.enable = false;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-connections
    epiphany
    yelp
    rygel
  ];
}
