return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dwh", function() require("dap.ui.widgets").hover() end, desc = "Widgets Hover", mode = { "n", "v" } },
      { "<leader>dwp", function() require("dap.ui.widgets").preview() end, desc = "Widgets Preview", mode = { "n", "v" } },
      {
        "<leader>dwf",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.frames)
        end,
        desc = "Widgets Float Frames",
      },
      {
        "<leader>dws",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.scopes)
        end,
        desc = "Widgets Float Scopes",
      },
      {
        "<leader>dwt",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.threads)
        end,
        desc = "Widgets Float Threads",
      },
    },
    config = function()
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
      sign("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpointCondition" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
      sign("DapStopped", { text = "", texthl = "DapStopped" })

      -- setup for new added dap
      local dap = require("dap")
      local dap_utils = require("dap.utils")
      -- c / cpp
      if not dap.adapters["codelldb"] then
        require("dap").adapters["codelldb"] = {
          type = "executable",
          command = "codelldb",
        }
      end
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = dap_utils.pick_file,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
          {
            name = "Attach to process",
            type = "codelldb",
            request = "attach",
            pid = dap_utils.pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
     -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    config = function()
      require("lazydev").setup({ library = { "nvim-dap-ui" } })
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = require("configs.mason.packages").dap,
      automatic_installation = false,
      handlers = {
        function(config)
          -- all sources with no handler get passed here
          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },
}
