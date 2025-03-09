-- Outer table
local utils = {}

-- Inner tables for holding data or fn pointers to convenient procedures
local sys = {}
local path = {}

function sys:load_data()
  local os_name = jit.os
  self.is_mac = os_name == "Darwin" or os_name == "OSX"
  self.is_linux = os_name == "Linux"
  self.is_windows = os_name == "Windows"
  self.is_wsl = vim.fn.has("wsl") == 1
  local arch = jit.arch
  self.arch = arch
  self.is_arm = arch == "arm64" or arch == "arm"
end

function path:load_data()
  -- Utils
  self.sep = sys.is_windows and "\\" or "/"
  self.join = function(inp, add)
    return (inp and inp or "") .. self.sep .. (add and add or "")
  end
end

function utils:load_data()
  self.sys = sys
  self.path = path
end

-- Loading everything into the tables
sys:load_data()
path:load_data()
utils:load_data()

return utils
