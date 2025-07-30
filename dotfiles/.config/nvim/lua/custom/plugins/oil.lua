return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explore = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      git = {
        add = function(_) return true end,
        mv = function(_) return true end,
        rm = function(_) return true end
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = {},
        ["<C-h>"] = {},
        ["<C-t>"] = {},
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        -- ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      view_options = {
        show_hidden = true,
      }
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  }
}
