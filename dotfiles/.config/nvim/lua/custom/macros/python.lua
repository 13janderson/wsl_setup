-- Want to load specific macros for this particular filetype
-- Can achieve this by setting autocmds on BufEnter for this filetype.
print("Hello from Macros")

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py" },
  group = vim.api.nvim_create_augroup("PythonMacros", {
    clear = true,
  }),
  callback = function(_)
    print("Setting Macro")
    vim.fn.setreg("p", 'yiwoprint()if""hpa: {}hpo')
  end
})

return {
}
