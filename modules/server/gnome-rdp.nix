{ config, pkgs, ... }:

{
  services.gnome.gnome-remote-desktop.enable = true;

  systemd.services.gnome-remote-desktop.wantedBy = [ "graphical.target" ];

  systemd.user.services.gnome-remote-desktop.wantedBy = [ "gnome-session.target" ];

  users.users.gnome-remote-desktop.extraGroups = [ "users" ];

  systemd.services.gnome-remote-desktop-cert = {
    description = "Generate TLS certificate for GNOME Remote Desktop";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      dir=/var/lib/remote-desktop
      mkdir -p "$dir"
      chgrp users "$dir"
      chmod 0750 "$dir"
      if [ ! -f "$dir/rdp-tls.crt" ]; then
        ${pkgs.openssl}/bin/openssl req -new -newkey rsa:3072 -days 3650 -nodes -x509 \
          -subj /CN=${config.networking.hostName} \
          -addext subjectAltName=DNS:${config.networking.hostName},DNS:${config.networking.hostName}.local \
          -keyout "$dir/rdp-tls.key" \
          -out "$dir/rdp-tls.crt"
        chgrp users "$dir/rdp-tls.key" "$dir/rdp-tls.crt"
        chmod 0640 "$dir/rdp-tls.key"
        chmod 0644 "$dir/rdp-tls.crt"
      fi
    '';
  };

  environment.etc."gnome-remote-desktop/grd.conf".text = ''
    [RDP]
    enabled=true
    tls-cert=/var/lib/remote-desktop/rdp-tls.crt
    tls-key=/var/lib/remote-desktop/rdp-tls.key
  '';

  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/remote-desktop/rdp" = {
        enable = true;
        view-only = false;
        tls-cert = "/var/lib/remote-desktop/rdp-tls.crt";
        tls-key = "/var/lib/remote-desktop/rdp-tls.key";
      };
      lockAll = true;
    }
  ];

  networking.firewall.allowedTCPPorts = [
    3389 # desktop sharing (user session)
    3390 # remote login (display manager)
  ];
}
