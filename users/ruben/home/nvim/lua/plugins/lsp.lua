return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/SchemaStore.nvim" },
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.nixd = {
        settings = {
          nixd = {
            nixpkgs = {
              expr = "import (builtins.getFlake \"/home/ruben/.config/nixos\").inputs.nixpkgs { }",
            },
          },
        },
      }
      opts.servers.pyright = {}
      opts.servers.ansiblels = {}
      opts.servers.marksman = {}
      opts.servers.yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      }
      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        python = { "ruff_format" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
      },
    },
  },
}
