{ pkgs, ... }:
# opencode is not (yet) packaged in nixpkgs, so it is built directly from open-vsx vsix
#
# To update opencode to the latest release, fetch the version, url and hash:
#   latest=$(curl -s https://open-vsx.org/api/sst-dev/opencode/latest | grep -o '"version":"[^"]*"' | head -1 | cut -d'"' -f4)
#   hash=$(nix-prefetch-url --type sha256 "https://open-vsx.org/api/sst-dev/opencode/$latest/file/sst-dev.opencode-$latest.vsix")
#   hash_sri_base_64=$(nix hash convert --hash-algo sha256 $hash)
#   echo "version = \"$latest\""
#   echo "url = \"https://open-vsx.org/api/sst-dev/opencode/$latest/file/sst-dev.opencode-$latest.vsix\""
#   echo "hash = \"$hash_sri_base_64\""
#
# REMINDER: check if pkgs.vscode-extensions.sst-dev.opencode exists
#
let
  opencode-extension = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "sst-dev";
      name = "opencode";
      version = "0.0.13";
    };
    vsix = pkgs.fetchurl {
      url = "https://open-vsx.org/api/sst-dev/opencode/0.0.13/file/sst-dev.opencode-0.0.13.vsix";
      hash = "sha256-6adXUaoh/OP5yYItH3GAQ7GpupfmTGaxkKP6hYUMYNQ=";
    };
  };
in
{
  home.packages = [
    pkgs.nixd
    pkgs.nixfmt
  ];

  programs.vscodium = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.redhat.vscode-yaml
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.ms-python.vscode-python-envs
        pkgs.vscode-extensions.esbenp.prettier-vscode
        opencode-extension
      ];
      userSettings = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "explorer.confirmDelete" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "json.schemaDownload.trustedDomains" = {
          "https://developer.microsoft.com/json-schemas/" = true;
          "https://docs.renovatebot.com" = true;
          "https://json-schema.org/" = true;
          "https://json.schemastore.org/" = true;
          "https://raw.githubusercontent.com/devcontainers/spec/" = true;
          "https://raw.githubusercontent.com/microsoft/vscode/" = true;
          "https://schemastore.azurewebsites.net/" = true;
          "https://www.schemastore.org/" = true;
        };
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "${pkgs.nixfmt}/bin/nixfmt";
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          nixd = {
            formatting = {
              formatCommand = "${pkgs.nixfmt}/bin/nixfmt";
            };
            nixpkgs = {
              expr = "import <nixpkgs> { }";
            };
          };
        };
        "redhat.telemetry.enabled" = false;
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
      };
    };
  };
}
