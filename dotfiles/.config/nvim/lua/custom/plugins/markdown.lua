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
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.md" },
        group = vim.api.nvim_create_augroup('PeekOpenOnEnter', { clear = true }),
        callback = function(_)
          local peek = require("peek")
          if not peek.is_open() then
            peek.close()
            vim.defer_fn(function()
              peek.open()
            end, 1)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>w', true, false, true), 'n', true)
          end
        end
      })
    end
  }
}
