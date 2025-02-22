-- open pdf files in external program
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local Job = require("plenary.job")
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    filename = string.sub(filename, 2, -2)
    vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")

    Job:new({
      command = "sioyek",
      args = { filename },
    }):start()
  end,
})
