{ ... }:
{
  services.prometheus.exporters.node = {
    # disabled until integrated into kube-prometheus stack
    enable = false;
    port = 9100;
    enabledCollectors = [
      "systemd"
      "processes"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 9100 ];

}
