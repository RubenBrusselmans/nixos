return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "saghen/blink.cmp" },
    keys = {
      { "<leader>um", "<cmd>Markview toggle<cr>", desc = "Markdown preview" },
      { "<leader>uM", "<cmd>Markview splitToggle<cr>", desc = "Markdown splitview" },
      { "<leader>uh", "<cmd>Markview hybridToggle<cr>", desc = "Markdown hybrid mode" },
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "latex", "typst" } },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-mini/mini.pick", version = false, opts = {} },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Links" },
      { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename note" },
      { "<leader>oi", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
      { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
    },
    opts = {
      workspaces = {
        { name = "vault", path = "~/Vault" },
      },
      daily_notes = {
        folder = "daily",
      },
      attachments = {
        img_folder = "attachments",
      },
      picker = {
        name = "mini.pick",
      },
      ui = {
        enable = false,
      },
      note_id_func = function(title)
        if title ~= nil then
          return title:gsub(" ", "-"):gsub("[^%w%-]", ""):lower()
        end
        return tostring(os.time())
      end,
    },
    config = function(_, opts)
      if vim.uv.fs_stat(vim.fn.expand("~/Vault")) ~= nil then
        require("obsidian").setup(opts)
      end
    end,
  },
}
