return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      insert_mappings = false, -- whether or not the open mapping applies in insert mode
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float',
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
    },
  },
}
