function Clear(delay_ms)
  delay_ms = delay_ms or 250
  local timer = vim.uv.new_timer()
  timer:start(delay_ms, 0, vim.schedule_wrap(function()
    vim.api.nvim_echo({ { "" } }, false, {})
  end))
end

function Print(tbl)
  print(vim.inspect(tbl))
end

-- Does not refresh the contents of the buffer but rather forces the contents to be reloaded
-- in the same buffer. This is achieved by creating a temporary buffer and then switching back
-- to the original.
function ReloadCurentBuffer()
  local init_buf_nr = vim.api.nvim_get_current_buf()
  local scratch_buf_nr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(scratch_buf_nr)
  vim.defer_fn(function()
    vim.api.nvim_set_current_buf(init_buf_nr)
    vim.api.nvim_buf_delete(scratch_buf_nr, {})
  end, 100)
end
