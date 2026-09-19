{
  config,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [
      wl-clipboard
      ripgrep
      fd
      lazygit
      gcc
      tree-sitter

      nixd
      nixfmt
      lua-language-server
      stylua
      pyright
      ruff
      yaml-language-server
      ansible-language-server
      marksman
      prettierd
    ];

    plugins = [ pkgs.vimPlugins.lazy-nvim ];

    initLua = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"
      vim.g.have_nerd_font = true

      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { import = "plugins" },
          { "mason.nvim", enabled = false },
          { "mason-lspconfig.nvim", enabled = false },
        },
        lockfile = vim.fn.expand("${config.home.homeDirectory}/.config/nixos/users/ruben/home/nvim/lazy-lock.json"),
        rocks = { enabled = false },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';
  };

  xdg.configFile."nvim/lua".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos/users/ruben/home/nvim/lua";
}
