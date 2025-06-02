return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        app = 'browser',
        auto_load = true,
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

      -- Close markdown on changing focus to another buffer or just closing it
      vim.api.nvim_create_autocmd("BufWinLeave", {
        pattern = { "*.md" },
        group = vim.api.nvim_create_augroup('PeekCloseOnLeave', { clear = true }),
        callback = function(_)
          local peek = require("peek")
          if peek.is_open() then
            pcall(function()
              peek.close()
            end)
          end
        end
      })
      vim.api.nvim_create_user_command("Preview", function(_)
        local peek = require("peek")
        if not peek.is_open() then
          peek.close()
          vim.defer_fn(function()
            local filetype = vim.bo.filetype
            if filetype == "markdown" then
              peek.open()
              print("Markdown preview opened")
            else
              print("Filetype must be markdown")
            end
            Clear(500)
          end, 1)
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>w', true, false, true), 'n', true)
        end
      end, {})
    end
  },
  {
    "epwalsh/obsidian.nvim",
    -- requires xclip for copying images from clipboard in linux
    version = "*", -- recommended, use latest release instead of latest commit
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    lazy = false,
    -- cond = vim.startswith(vim.fn.getcwd(), vim.fn.expand "~/vault/"),
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/vault/",
        },
      },
      new_notes_location = "current_dir",
      open_notes_in = "current",
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 1 chars.
        min_chars = 1,
      },
      ui = {
        enable = false,
      },
      -- Specify how to handle attachments.
      attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        img_folder = "assets/imgs", -- This is the default

        -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
        ---@return string
        img_name_func = function()
          -- Prefix image names with timestamp.
          return string.format("%s", os.time())
        end,

        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          path = client:vault_relative_path(path) or path
          return string.format("![%s](%s)", path.name, path)
        end,
      },
    },
    config = function(_, opts)
      local obsidian = require("obsidian")
      obsidian.setup(opts)
      -- Keymappings here
      vim.keymap.set("n", "gf", obsidian.util.gf_passthrough, nil)
      vim.keymap.set("n", "<M-x>", obsidian.util.toggle_checkbox, nil)
      vim.keymap.set("n", "<M-i>", function()
        vim.cmd(string.format("ObsidianPasteImg %s", opts.attachments.img_name_func()))
        local vault = vim.fn.expand "~/vault/"
        local keys = string.format("_ci(%s<C-C>p", vault)
        local termcodes = vim.api.nvim_replace_termcodes(keys, true, false, true)
        vim.api.nvim_feedkeys(termcodes, "n", false)
      end, nil)
      vim.keymap.set("n", "<cr>", obsidian.util.smart_action, nil)
    end,
  }
}
