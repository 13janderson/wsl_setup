return {
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
      -- vim.api.nvim_create_autocmd("BufEnter", {
      --   pattern = { "*.md" },
      --   group = vim.api.nvim_create_augroup('PeekOpenOnEnter', { clear = true }),
      --   callback = function(_)
      --     local peek = require("peek")
      --     if not peek.is_open() then
      --       peek.close()
      --       vim.defer_fn(function()
      --         peek.open()
      --       end, 1)
      --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>w', true, false, true), 'n', true)
      --     end
      --   end
      -- })
    end
  },
  {
    "epwalsh/obsidian.nvim",
    -- requires xclip for copying images from clipboard in linux
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      "VimEnter " .. vim.fn.expand "~/vault/*"
      -- refer to `:h file-pattern` for more examples
    },
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
    },
    new_notes_location = "current_dir",
    open_notes_in = "current",
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
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
        return string.format("%s-", os.time())
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
  }
}
