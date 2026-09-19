{ ... }:
{
  dconf = {
    enable = true;

    settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "org.gnome.Console.desktop"
          "librewolf.desktop"
          "thunderbird.desktop"
          "signal.desktop"
          "element-desktop.desktop"
          "org.gnome.Calculator.desktop"
          "org.gnome.TextEditor.desktop"
          "startcenter.desktop"
          "codium.desktop"
          "org.remmina.Remmina.desktop"
          "org.gnome.Settings.desktop"
        ];
      };

      ## keybindings
      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
        switch-to-application-6 = [ ];
        switch-to-application-7 = [ ];
        switch-to-application-8 = [ ];
        switch-to-application-9 = [ ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        move-to-workspace-1 = [ "<Super><Shift>1" ];
        move-to-workspace-2 = [ "<Super><Shift>2" ];
        move-to-workspace-3 = [ "<Super><Shift>3" ];
        move-to-workspace-4 = [ "<Super><Shift>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        close = [ "<Super>BackSpace" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
        name = "Terminal";
        command = "kgx";
        binding = "<Super>Return";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot" = {
        name = "Flameshot";
        command = "flameshot gui";
        binding = "<Super><Shift>S";
      };

      ## night light
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-automatic = false;
        night-light-schedule-from = 20.0;
        night-light-schedule-to = 6.0;
        night-light-temperature = 4000;
      };

      "org/gnome/settings-daemon/plugins/power" = {
        power-profile = "power-saver";
        sleep-inactive-ac-type = "nothing";
      };

      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/session" = {
        idle-delay = 0; # disabled
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 5;
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
      };
    };
  };
}
