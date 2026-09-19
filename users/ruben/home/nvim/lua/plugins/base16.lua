local has_matugen = vim.uv.fs_stat(vim.fn.stdpath("config") .. "/lua/matugen.lua") ~= nil

local specs = {}

if has_matugen then
  specs[#specs + 1] = {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function() end,
    },
  }
end

specs[#specs + 1] = {
  "RRethy/base16-nvim",
  lazy = false,
  enabled = has_matugen,
  config = function()
    local matugen_path = vim.fn.stdpath("config") .. "/lua/matugen.lua"

    local function apply_transparency()
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

      local links = {
        SnacksDashboardHeader = "Title",
        SnacksDashboardFooter = "Comment",
        SnacksDashboardDesc = "Comment",
        SnacksDashboardKey = "Special",
        SnacksDashboardIcon = "Special",
        SnacksDashboardSpecial = "Special",
        SnacksDashboardDir = "Directory",
        SnacksDashboardFile = "Normal",
      }
      for group, target in pairs(links) do
        vim.api.nvim_set_hl(0, group, { link = target })
      end
    end

    local function reload()
      package.loaded["matugen"] = nil
      local ok, matugen = pcall(require, "matugen")
      if ok then
        matugen.setup()
        vim.g.colors_name = "base16-noctalia"
        apply_transparency()
      end
    end

    reload()

    if _G.__base16_fs_poll then
      _G.__base16_fs_poll:stop()
      _G.__base16_fs_poll:close()
    end
    local poll = vim.uv.new_fs_poll()
    _G.__base16_fs_poll = poll
    poll:start(matugen_path, 2000, function(err)
      if not err then
        vim.schedule(reload)
      end
    end)
  end,
}

return specs
