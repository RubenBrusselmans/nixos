{ lib, pkgs, ... }:

{
  users.groups.k3s = { };

  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-mode=640"
      "--write-kubeconfig-group=k3s"
      "--data-dir=/data/crypt/k3s"
    ];
  };

  # do not auto-start at boot, requires /data/crypt mounted first
  systemd.services.k3s = {
    wantedBy = lib.mkForce [ ];
    serviceConfig.ExecStartPre = [ "${pkgs.util-linux}/bin/mountpoint /data/crypt" ];
  };

  networking.firewall.allowedTCPPorts = [ 6443 ];

  environment.sessionVariables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";

  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
    kompose
  ];
}
