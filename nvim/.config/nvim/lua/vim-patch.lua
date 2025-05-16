-- open pdf/image files in external program
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.pdf", "*.png", "*.jpg" },
  callback = function()
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    filename = string.sub(filename, 2, -2)
    vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")

    local Job = require("plenary.job")
    local job = { command = "", args = { filename } }
    if string.match(filename, "%.pdf$") then
      job.command = "sioyek"
    elseif string.match(filename, "%.png$") then
      job.command = "qlmanage"
      job.args = { "-p", filename }
    else
      return
    end

    Job:new(job):start()
  end,
})
