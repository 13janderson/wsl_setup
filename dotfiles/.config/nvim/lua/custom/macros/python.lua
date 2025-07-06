-- Want to load specific macros for this particular filetype
-- Can achieve this by setting autocmds on BufEnter for this filetype.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py" },
  group = vim.api.nvim_create_augroup("PythonMacros", {
    clear = true,
  }),
  callback = function(_)
    print("Registering Python Macros")
    -- Format string macro @p on current word
    -- While this is horrible to look at, it just works for python
    -- and is much easier to implemet than registering auto commands.
     -- Also allows us to make use of macros as opposed to keybindings or 
    -- auto-commands.
    vim.fn.setreg("p", 'yiwoprint()if""hpa: {}hp_')
  end,
})

return {}
