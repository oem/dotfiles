local map_key = vim.api.nvim_set_keymap
local cmd = vim.cmd

local function autocmd(group, cmds, clear)
  clear = clear == nil and false or clear
	group = group == nil and false or group
  if type(cmds) == 'string' then cmds = {cmds} end
	if group then cmd('augroup ' .. group) end
  if clear then cmd [[au!]] end
  for _, c in ipairs(cmds) do cmd('autocmd ' .. c) end
	if group then cmd [[augroup END]] end
end

local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end

return {map = map, autocmd = autocmd}
