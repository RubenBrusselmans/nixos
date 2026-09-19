return {
  {
    "folke/tokyonight.nvim",
    enabled = vim.uv.fs_stat(vim.fn.stdpath("config") .. "/lua/matugen.lua") == nil,
    opts = {
      transparent = true,
    },
  },
}
