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
        dap = true,
        dap_ui = true,
        dashboard = true,
        flash = true,
        illuminate = {
          enabled = true,
          lsp = false,
        },
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        markdown = true,
        mason = true,
        navic = {
          enabled = true,
          custom_bg = "lualine",
        },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        nvim_surround = true,
        overseer = true,
        render_markdown = true,
        telescope = {
          enabled = true,
          -- theme = "nvchad",
        },
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        which_key = true,
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
  end,
}
