return{
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
          vim.api.nvim_create_autocmd("BufEnter", {
              pattern = {"*.md"},
              callback = function (_)
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
