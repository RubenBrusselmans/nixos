{ ... }:

{
  # pipewire-jack for low-latency audio (guitarix etc.)
  services.pipewire.jack.enable = true;

  # force Scarlett 2i2 to use 44.1kHz to avoid distortion
  environment.etc."wireplumber/wireplumber.conf.d/51-focusrite.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [
          { device.name = "~alsa_card.usb-Focusrite.*" }
        ]
        actions = {
          update-props = {
            api.acp.probe-rate = 44100
          }
        }
      }
    ]
  '';
}
