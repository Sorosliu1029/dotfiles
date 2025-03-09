return {
  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  -- show color on #hex, color literal
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      lazy_load = true,
      -- other setup options
    },
  },
  -- indenting
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
    },
    main = "ibl",
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup({
        scope = { highlight = highlight },
        exclude = { filetypes = { "dashboard" } },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  -- change surround, like '"{[(<
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      -- Configuration here, or leave empty to use defaults
    },
  },
  -- fix nvim-surround not showing on which-key
  -- ref: https://github.com/kylechui/nvim-surround/issues/354#issuecomment-2571421653
  {
    "roobert/surround-ui.nvim",
    dependencies = {
      "kylechui/nvim-surround",
      "folke/which-key.nvim",
    },
    opts = {
      root_key = "S",
    },
  },
  -- highlight other uses of word under cursor
  {
    "RRethy/vim-illuminate",
  },
  -- folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    init = function()
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
    opts = {},
  },
  -- renaming
  {
    "smjonas/inc-rename.nvim",
    dependencies = {
      "folke/noice.nvim",
    },
    init = function()
      vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "IncRename the word under cursor" })
    end,
    config = function()
      require("inc_rename").setup({})
      require("noice").setup({ presets = { inc_rename = true } })
    end,
  },
  -- splitting / joining blocks of code
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    keys = {
      { "<leader>jt", "<cmd>TSJToggle<cr>", desc = "Treesj: Toggle node under cursor" },
      { "<leader>jj", "<cmd>TSJJoin<cr>", desc = "Treesj: Join node under cursor" },
      { "<leader>js", "<cmd>TSJSplit<cr>", desc = "Treesj: Split node under cursor" },
    },
    opts = {
      ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
      use_default_keymaps = false,
    },
  },
  -- Show function signature when you type
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {},
  },
}
