local INTERVAL = 2 * 1000 -- ms
local timer = vim.loop.new_timer()

timer:start(0, INTERVAL, vim.schedule_wrap(function()
  vim.cmd[[checktime]]
end))
