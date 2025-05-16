function Clear(delay_ms)
  delay_ms = delay_ms or 250
  local timer = vim.uv.new_timer()
  timer:start(delay_ms, 0, vim.schedule_wrap(function()
    vim.api.nvim_echo({{""}}, false, {})
  end))
end

function Print(tbl)
  print(vim.inspect(tbl))
end
