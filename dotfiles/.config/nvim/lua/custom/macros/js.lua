-- Want to load specific macros for this particular filetype
-- Can achieve this by setting autocmds on BufEnter for this filetype.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.js", "*.ts" },
  group = vim.api.nvim_create_augroup("JSMacros", {
    clear = true,
  }),
  callback = function(_)
    -- Format string macro @p on current word
    vim.fn.setreg("p", 'yiwoconsole.log()i``hpa:${}hp_')
  end,
})

-- Removing these auto commands on BufLeave would be nice as well

return {}
