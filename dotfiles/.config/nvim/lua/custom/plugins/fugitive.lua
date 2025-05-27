return{
  'tpope/vim-fugitive',
  config = function(_)
    -- Use navigating merge conflict defaults for now [c for previous ]c for next conflict
    -- Set keybindings for resolving merge conflicts
    vim.keymap.set("n", "<leader>(", ":diffget //2<CR>")
    vim.keymap.set("n", "<leader>)", ":diffget //3<CR>")
    -- vim.keymap.set("n", "<leader>p", function ()
    --   vim.cmd("G push")
    --   Clear(250)
    -- end)
    -- vim.keymap.set("n", "<leader>P", function ()
    --   vim.cmd("G pull")
    --   Clear(250)
    -- end)
    vim.keymap.set("n", "<leader>c", function ()
      local success = pcall(function() vim.cmd("silent G commit -a --no-verify")
      end)
      if success then
        vim.api.nvim_buf_set_lines(0, 0, 1, true, {"feat: "})
      end
    end)
  end

}
