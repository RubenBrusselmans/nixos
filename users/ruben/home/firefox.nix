{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.web-eid-app ];
    package = pkgs.firefox.override {
      pkcs11Modules = [ pkgs.eid-mw ];
    };
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
