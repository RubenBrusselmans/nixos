{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.web-eid-app
      pkgs.unstable.beidconnect
    ];
    package = pkgs.firefox.override {
      pkcs11Modules = [ pkgs.eid-mw ];
    };
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    policies = {
      ExtensionSettings = {
        "beidconnect@bosa.be" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/beidconnect/latest.xpi";
        };
      };
    };
  };
}
