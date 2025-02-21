return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    disabled_filetypes = { "dashboard" },
    disabled_keys = {
      ["<Up>"] = {},
      ["<Down>"] = {},
      ["<Left>"] = {},
      ["<Right>"] = {},
    },
    restricted_keys = {
      ["j"] = {},
      ["k"] = {},
      ["h"] = {},
      ["l"] = {},
    },
  },
}
