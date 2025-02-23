return {
  "alexghergh/nvim-tmux-navigation",
  init = function()
    local nvim_tmux_nav = require("nvim-tmux-navigation")
    vim.keymap.set("n", "<A-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = "Nvim Tmux navigate left" })
    vim.keymap.set("n", "<A-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { desc = "Nvim Tmux navigate down" })
    vim.keymap.set("n", "<A-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Nvim Tmux navigate up" })
    vim.keymap.set("n", "<A-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = "Nvim Tmux navigate right" })
    vim.keymap.set("n", "<A-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, { desc = "Nvim Tmux navigate last active" })
  end,
  opts = {
    disable_when_zoomed = true, -- defaults to false
  },
}
