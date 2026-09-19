{ pkgs, ... }:

{
  # fix AMD GPU overdrive
  # https://gitlab.freedesktop.org/drm/amd/-/issues/3549
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffff7fff" ];

  environment.systemPackages = with pkgs; [
    radeontop
    amdgpu_top
  ];
}
