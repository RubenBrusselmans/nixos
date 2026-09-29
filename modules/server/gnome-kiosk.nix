{ pkgs, ... }:

let
  # Upstream hardcodes a 50% stick trigger with narrow hysteresis (releases only
  # below 30%) and a 60ms autorepeat — unusable for TV navigation. Raise the
  # trigger to 75%, widen the release band, and slow repeats to 4 steps/sec.
  jellyfin-desktop = pkgs.jellyfin-desktop.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace src/input/InputSDL.cpp \
        --replace-fail 'std::abs(value) > 32768 / 2' 'std::abs(value) > 32768 / 4 * 3' \
        --replace-fail 'std::abs(value) < 10000' 'std::abs(value) < 14000'
      substituteInPlace src/input/InputComponent.cpp \
        --replace-fail '#define INITAL_AUTOREPEAT_MSEC 650' '#define INITAL_AUTOREPEAT_MSEC 400' \
        --replace-fail '#define AUTOREPEAT_MSEC 60' '#define AUTOREPEAT_MSEC 250'
    '';
  });
in

{
  # disable workspaces overview at login
  environment.systemPackages = [
    pkgs.gnomeExtensions.no-overview
    jellyfin-desktop
  ];
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
