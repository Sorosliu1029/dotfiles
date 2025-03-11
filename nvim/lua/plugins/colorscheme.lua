return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        cmp = true,
        dashboard = true,
        flash = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        mason = true,
        markdown = true,
        render_markdown = true,
        neotree = true,
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
        overseer = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
