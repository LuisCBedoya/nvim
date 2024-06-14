local home = os.getenv('HOME')
local dap = require('dap')

local function get_python_module()
  return vim.fn.input('Which module?: ')
end

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'launch module',
    justMyCode = false,

    module = function()
      return get_python_module()
    end,
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end,
  },
}
