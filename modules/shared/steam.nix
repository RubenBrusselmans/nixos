{ ... }:
{
  programs.steam = {
    enable = true;
    # fix theme issues in gnome - not sure if still required
    # extraPackages = with pkgs; [
    #   adwaita-icon-theme
    # ];
  };

  # 32-bit Mesa/RADV drivers (for older games)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # temporarily apply performance tweaks to games
  # requires steam launch option: gamemoderun %command%
  programs.gamemode.enable = true;
}
