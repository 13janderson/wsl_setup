return {
  'tpope/vim-fugitive',
  config = function(_)
    -- Use navigating merge conflict defaults for now [c for previous ]c for next conflict
    -- Set keybindings for resolving merge conflicts
    vim.keymap.set("n", "<leader>(", ":diffget //2<CR>")
    vim.keymap.set("n", "<leader>)", ":diffget //3<CR>")
    vim.keymap.set("n", "<leader>c", function()
      vim.cmd("silent G commit -a --no-verify")
      vim.api.nvim_buf_set_lines(0, 0, 1, true, { "feat: " })
    end)
  end

}
