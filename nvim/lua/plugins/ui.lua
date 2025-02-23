return {
  -- bottom line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      -- copy from: https://github.com/folke/trouble.nvim?tab=readme-ov-file#statusline-component
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        -- The following line is needed to fix the background color
        -- Set it to the lualine section you want to use
        hl_group = "lualine_c_normal",
      })

      return {
        options = {
          theme = "dracula",
        },

        sections = {
          lualine_c = {
            "filename",
            {
              symbols.get,
              cond = symbols.has,
            },
          },
          lualine_x = {
            -- Show @recording messages
            -- ref: https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#show-recording-messages
            {
              require("noice").api.status.mode.get,
              cond = function()
                local match = "recording"
                local statusMode = require("noice").api.status.mode
                return statusMode.has() and string.sub(statusMode.get(), 0, string.len(match)) == match
              end,
              color = { fg = "#ff9e64" },
            },
            -- Show GitHub Copilot status
            -- ref: https://github.com/jonahgoldwastaken/copilot-status.nvim?tab=readme-ov-file#example-with-lualine
            {
              require("copilot_status").status_string,
              cond = require("copilot_status").enabled,
              color = { fg = "#00ff00" },
            },
            "encoding",
            "fileformat",
            "filetype",
          },
        },
      }
    end,
  },
  -- top line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        separator_style = "padded_slant",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
      },
    },
  },
  -- notification
  {
    "rcarriga/nvim-notify",
    init = function()
      vim.notify = require("notify")
    end,
    opts = {
      -- disable focusing on notify window
      -- ref: https://github.com/rcarriga/nvim-notify/issues/183#issuecomment-1464892813
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { focusable = false })
      end,
    },
  },
  -- UI components
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      routes = {
        -- Hide `written` messages
        -- ref: https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-written-messages
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },

        -- Hide `jdtls` lsp messages
        -- ref: https://github.com/folke/noice.nvim/issues/511#issuecomment-1595272018
        {
          filter = {
            event = "lsp",
            kind = "progress",
            cond = function(message)
              local client = vim.tbl_get(message.opts, "progress", "client")
              return client == "jdtls" -- skip jdtls progress
            end,
          },
          opts = { skip = true },
        },

        -- always route 'AutoSave' message to bottom right corner
        {
          view = "mini",
          filter = { event = "msg_show", find = "AutoSave:" },
        },

        -- always route any messages with more than 20 lines to the split view
        {
          view = "split",
          filter = { event = "msg_show", min_height = 20 },
        },
      },
    },
    config = function(_, opts)
      require("telescope").load_extension("noice")
      require("noice").setup(opts)
    end,
  },
  -- code context on top line
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      lsp = { auto_attach = true },
    },
  },
  -- outline
  {
    "hedyhli/outline.nvim",
    init = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
    end,
    opts = {
      -- Your setup opts here (leave empty to use defaults)
    },
  },
}
