return{
  'tpope/vim-fugitive',
  config = function(_)
    -- Use navigating merge conflict defaults for now [c for previous ]c for next conflict
    -- Set keybindings for resolving merge conflicts
    vim.keymap.set("n", "<leader>h", ":diffget //2<CR>")
    vim.keymap.set("n", "<leader>l", ":diffget //3<CR>")
    vim.keymap.set("n", "<leader>p", function ()
      -- What if we did this in a pcall?
      local success = pcall(vim.cmd("silent G push"))
      if success then
        print("/")
      else
        print("x")
      end
      Clear(250)
    end)
    vim.keymap.set("n", "<leader>P", function ()
      vim.cmd("G pull")
      print("Fugitive ↓")
      Clear(250)
    end)
    vim.keymap.set("n", "<leader>c", function ()
      vim.cmd("G commit -a")
      vim.api.nvim_buf_set_lines(0, 0, 1, true, {"feat: "})
    end)
  end

}
