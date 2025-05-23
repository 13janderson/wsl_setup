return
  {
    {
      "mfussenegger/nvim-dap",
      lazy = true,
      -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and modified.
      keys = {
        {
          "<leader>db",
          function() require("dap").toggle_breakpoint() end,
          desc = "Toggle Breakpoint",
        },
        {
          "<leader>dc",
          function() require("dap").continue() end,
          desc = "Continue",
        },
        {
          "<leader>dC",
          function() require("dap").run_to_cursor() end,
          desc = "Run to Cursor",
        },
        {
          "<leader>dT",
          function() require("dap").terminate() end,
          desc = "Terminate",
        },
      },
      config = function()
        local dap = require("dap")

        -- Configure js-debug-adapter for TypeScript/JavaScript
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}", -- Let DAP pick a free port
          executable = {
            command = "js-debug-adapter", -- Provided by mason-nvim-dap
            args = { "${port}" },
          },
        }

        for _, language in ipairs { "typescript", "javascript" } do
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              runtimeExecutable = "ts-node",
              sourceMaps = true, -- Enable source maps
              resolveSourceMapLocations = { -- Specify where to find source maps
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
            },
          }
        end
      end
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      ---@type MasonNvimDapSettings
      opts = {
        -- This line is essential to making automatic installation work
        -- :exploding-brain
        handlers = {},
        automatic_installation = {
          -- These will be configured by separate plugins.
          exclude = {
          },
        },
        -- DAP servers: Mason will be invoked to install these if necessary.
        ensure_installed = {
          "python",
          "js",
          "go",
        },
      },
      dependencies = {
        "mfussenegger/nvim-dap",
        "williamboman/mason.nvim",
      },
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      config = true,
      dependencies = {
        "mfussenegger/nvim-dap",
      },
    },
    {
      "rcarriga/nvim-dap-ui",
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

      end,
      keys = {
        {
          "<leader>du",
          function()
            require("dapui").toggle({})
          end,
          desc = "Dap UI"
        },
      },
      dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
      },
    }
  }
