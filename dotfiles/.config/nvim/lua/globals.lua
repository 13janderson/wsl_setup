function Clear(delay_ms)
  local timer = vim.uv.new_timer()
  timer:start(delay_ms, 0, vim.schedule_wrap(function()
    vim.api.nvim_echo({{""}}, false, {})
  end))
end

function Print(table)
  print(vim.inspect(table))
end
