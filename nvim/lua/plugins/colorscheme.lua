return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        mason = true,
        neotest = true,
        noice = true,
        navic = {
          enabled = true,
          custom_bg = "lualine",
        },
        notify = true,
        nvim_surround = true,
        lsp_trouble = true,
        which_key = true,
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
