return {
	-- bottom line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "dracula",
				},
				sections = {
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
			})
		end,

		-- copy from: https://github.com/folke/trouble.nvim?tab=readme-ov-file#statusline-component
		options = function(_, opts)
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
			table.insert(opts.sections.lualine_c, {
				symbols.get,
				cond = symbols.has,
			})
		end,
		-- end copy
	},
	-- top line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
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
			})
		end,
	},
	-- notification
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- disable focusing on notify window
				-- ref: https://github.com/rcarriga/nvim-notify/issues/183#issuecomment-1464892813
				on_open = function(win)
					vim.api.nvim_win_set_config(win, { focusable = false })
				end,
			})

			vim.notify = require("notify")
		end,
	},
	-- UI components
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
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
				},
			})
		end,
	},
	-- code context on top line
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("nvim-navic").setup({
				lsp = { auto_attach = true },
			})
		end,
	},
	-- outline
	{
		"hedyhli/outline.nvim",
		init = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
		end,
		config = function()
			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
			})
		end,
	},
}
