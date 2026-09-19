{ pkgs, ... }:
{
  services.printing.enable = true;

  hardware.sane.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  environment.systemPackages = with pkgs; [
    sane-airscan
    simple-scan
  ];
}
