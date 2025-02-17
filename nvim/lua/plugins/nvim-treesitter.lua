return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "heex", "javascript", "html", "css", "java", "python", "julia", "cpp", "json", "yaml",
                              "typescript", "bash", "haskell", "go", "latex", "rust", "cmake", "dockerfile", "git_config", "gitattributes", "gitignore",
                              "ispc", "jinja", "jq", "make", "proto", "sql", "ssh_config", "tmux", "xml" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
}
