return {
  'tpope/vim-fugitive',
  config = function(_)
    -- Use navigating merge conflict defaults for now [c for previous ]c for next conflict
    -- Set keybindings for resolving merge conflicts
    vim.keymap.set("n", "<leader>(", ":diffget //2<CR>")
    vim.keymap.set("n", "<leader>)", ":diffget //3<CR>")
    vim.keymap.set("n", "<leader>c", function()
      -- local diff = vim.cmd("G diff")
      local status = vim.fn.execute("G status --untracked-files=no --porcelain", 'silent')
      local status_len = string.len(status)
      if status_len > 1 then
        vim.cmd("G commit -a --no-verify")
        vim.api.nvim_buf_set_lines(0, 0, 1, true, { "feat: " })
      else
        print("No changes to commit")
        Clear(250)
      end
    end)
  end

}
