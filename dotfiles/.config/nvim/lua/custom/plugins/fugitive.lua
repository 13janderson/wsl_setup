return{
  'tpope/vim-fugitive',
  config = function(_)
    -- Use navigating merge conflict defaults for now [c for previous ]c for next conflict
    -- Set keybindings for resolving merge conflicts
    vim.keymap.set("n", "<leader>ch", ":diffget //2<CR>")
    vim.keymap.set("n", "<leader>cl", ":diffget //3<CR>")
  end

}
