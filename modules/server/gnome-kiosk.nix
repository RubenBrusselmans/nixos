{ pkgs, ... }:

{
  # disable workspaces overview at login
  environment.systemPackages = [ pkgs.gnomeExtensions.no-overview ];
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [ "no-overview@fthx" ];
      };
      lockAll = true;
    }
  ];

  # kiosk sessions auto-login; the keyring must be set with a blank pass
  services.displayManager.autoLogin = {
    enable = true;
    user = "gaming";
  };

  programs.firefox.enable = true;

  # autostart steam in big picture mode
  systemd.user.services.steam-bpm = {
    description = "Steam (Gamepad UI) autostart";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
      ExecStart = "${pkgs.steam}/bin/steam -gamepadui -silent";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  # prevent gnome from going to sleep
  systemd.user.services.gnome-no-sleep = {
    description = "Disable GNOME idle and suspend";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "oneshot";

      ExecStart = "${pkgs.glib}/bin/gsettings set org.gnome.desktop.session idle-delay 0";

      ExecStartPost = [
        "${pkgs.glib}/bin/gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'"
        "${pkgs.glib}/bin/gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'"
        "${pkgs.glib}/bin/gsettings set org.gnome.settings-daemon.plugins.power idle-dim false"
      ];
    };
  };
}
