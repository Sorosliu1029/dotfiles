return {
  "pocco81/auto-save.nvim",
  opts = {
    debounce_delay = 10000, -- save every 10s
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      local ignoreSaveFiletypes = { "TelescopePrompt", "gitcommit" }
      if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), ignoreSaveFiletypes) then
        return true -- met condition(s), can save
      end
      return false -- can't save
    end,
  },
}
