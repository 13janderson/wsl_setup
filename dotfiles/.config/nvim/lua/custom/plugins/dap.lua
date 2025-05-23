return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      "williamboman/mason.nvim",
    },

    -- Plugin configuration
    config = function()
      local dap = require("dap")

      -- -- Configure Mason for managing debug adapters with auto-install
      -- require("mason").setup({
      --   ensure_installed = { "js-debug-adapter" }, -- Auto-install js-debug-adapter
      -- })
      --
      -- -- Check if ts-node is installed
      -- local ts_node_path = vim.fn.exepath("ts-node")
      -- if ts_node_path == "" then
      --   print("Error: ts-node not found. Please install it with 'npm install -g ts-node'")
      --   return
      -- end
      --
      -- -- Construct js-debug-adapter path
      -- local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
      --
      -- -- Check if the adapter executable exists
      -- if not vim.loop.fs_stat(js_debug_path) then
      --   print("Error: js-debug-adapter not found at " .. js_debug_path)
      --   print("Please ensure js-debug-adapter is installed via :MasonInstall js-debug-adapter and Mason has completed installation")
      --   return
      -- end

      -- Configure DAP adapter for JavaScript/TypeScript (vscode-js-debug)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "8123",
        executable = {
          command = "js-debug-adapter",
        },
      }

      -- Configuration for TypeScript debugging
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch File",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node", -- Use resolved ts-node path
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          outFiles = { "${workspaceFolder}/**/*.js" },
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        },
      }

      -- Basic DAP keybindings
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<leader>dv", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<leader>do", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio"
    },
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function() 
        dapui.open()
      end

      dap.listeners.after.event_terminated["dapui_config"] = function() 
        dapui.close()
      end
      
      dap.listeners.after.event_exited["dapui_config"] = function() 
        dapui.close()
      end

      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAPUI: Toggle" })
    end
  }
}
