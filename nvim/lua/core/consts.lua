local utils = require('core.globals')
local consts = {}

local dirs = {}

dirs.home = os.getenv('HOME')
dirs.nvim = vim.fn.stdpath('config')
dirs.nvim_data = vim.fn.stdpath('data')
dirs.lua = utils.path.join(dirs.nvim, consts.lua)

--
consts.dirs = dirs

return consts

