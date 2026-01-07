-- DAP (Debug Adapter Protocol) Configuration

local dap = require("dap")
local dapui = require("dapui")

-- Enable DAP logging
dap.set_log_level('TRACE')  -- Can be TRACE, DEBUG, INFO, WARN, ERROR

-- Setup Mason for DAP adapters (Mason itself is initialized in init.lua)
require("mason-nvim-dap").setup({
  ensure_installed = { "codelldb" },
  automatic_installation = true,
  handlers = {},
})

-- DAP UI Setup
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  element_mappings = {},
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  force_buffers = true,
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.35 },  -- Increased size for variables
        { id = "watches", size = 0.20 },
        { id = "stacks", size = 0.25 },
        { id = "breakpoints", size = 0.20 },
      },
      size = 45,  -- Wider sidebar
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      size = 0.25,
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
      disconnect = "⏏",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
    max_value_lines = 100,
  },
})

-- Virtual text for variable values
require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  filter_references_pattern = '<module',
  virt_text_pos = 'eol',
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil
})

-- Automatically open/close DAP UI with logging
dap.listeners.after.event_initialized["dapui_config"] = function()
  vim.notify("DAP: Session initialized", vim.log.levels.INFO)
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function(session, body)
  vim.notify("DAP: Session terminated - " .. vim.inspect(body), vim.log.levels.WARN)
  -- Don't auto-close to see what happened
  -- dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function(session, body)
  vim.notify("DAP: Process exited with code " .. tostring(body.exitCode), vim.log.levels.WARN)
  -- Don't auto-close to see what happened
  -- dapui.close()
end

-- Add error listener
dap.listeners.before.event_output["dapui_config"] = function(session, body)
  if body.category == "stderr" then
    vim.notify("DAP stderr: " .. body.output, vim.log.levels.ERROR)
  end
end

-- Signs for breakpoints and debugging
vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DapBreakpoint', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='◆', texthl='DapBreakpointCondition', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='✗', texthl='DapBreakpointRejected', linehl='', numhl= ''})
vim.fn.sign_define('DapLogPoint', {text='◎', texthl='DapLogPoint', linehl='', numhl= ''})
vim.fn.sign_define('DapStopped', {text='→', texthl='DapStopped', linehl='DapStoppedLine', numhl= ''})

-- Highlight groups
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e06c75' })
vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#e5c07b' })
vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#ff6c6b' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e3440' })

-- Language specific configurations

-- Python
local python_path = vim.fn.exepath('python3') or vim.fn.exepath('python')
if python_path ~= '' then
  require('dap-python').setup(python_path)
  
  -- Python test configurations
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Launch file with arguments',
    program = '${file}',
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      return vim.split(args_string, " ")
    end,
  })
  
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Django',
    program = '${workspaceFolder}/manage.py',
    args = { 'runserver', '--noreload' },
    django = true,
  })
  
  table.insert(dap.configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Flask',
    module = 'flask',
    env = { FLASK_APP = '${workspaceFolder}/app.py', FLASK_ENV = 'development' },
    args = { 'run', '--no-debugger', '--no-reload' },
  })
end

-- Go
require('dap-go').setup({
  dap_configurations = {
    {
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  delve = {
    path = "dlv",
    initialize_timeout_sec = 20,
    port = "${port}",
    args = {},
  },
})

-- Rust/C/C++ adapters
-- Use Mason's codelldb with automatic Rust support
require("mason-nvim-dap").setup({
  handlers = {
    codelldb = function(config)
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local extension_path = mason_path .. "/packages/codelldb/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      
      config.adapters = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--liblldb", liblldb_path, "--port", "${port}" },
        },
      }
      require("mason-nvim-dap").default_setup(config)
    end,
  },
})

-- Also setup lldb-vscode as fallback
dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}

-- GDB adapter
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

-- C++ configurations
dap.configurations.cpp = {
  {
    name = 'Launch (codelldb)',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
  {
    name = 'Launch (lldb)',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- C uses the same configuration as C++
dap.configurations.c = dap.configurations.cpp

-- Rust configurations
dap.configurations.rust = {
  {
    name = 'Debug executable',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      if args_string == "" then
        return {}
      end
      return vim.split(args_string, " ")
    end,
  },
  {
    name = 'Debug unit tests',
    type = 'codelldb',
    request = 'launch',
    program = function()
      -- Look for test executables in target/debug/deps/
      return vim.fn.input('Path to test executable: ', vim.fn.getcwd() .. '/target/debug/deps/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local test_name = vim.fn.input('Test name (or empty for all): ')
      if test_name ~= '' then
        return { test_name, '--exact', '--nocapture' }
      else
        return { '--nocapture' }
      end
    end,
  },
  {
    name = 'Attach to process',
    type = 'codelldb',
    request = 'attach',
    pid = require('dap.utils').pick_process,
    stopOnEntry = false,
  },
}

-- Node.js/TypeScript
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
}

-- Alternative: Use vscode-js-debug if available
local js_debug_path = vim.fn.stdpath("data") .. "/vscode-js-debug"
if vim.fn.isdirectory(js_debug_path) == 1 then
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {js_debug_path .. "/out/src/vsDebugServer.js", "${port}"},
    }
  }
end

dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    type = 'node2',
    request = 'attach',
    name = 'Attach to process',
    processId = require('dap.utils').pick_process,
    cwd = vim.fn.getcwd(),
  },
}

dap.configurations.typescript = {
  {
    type = 'node2',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    outFiles = {"${workspaceFolder}/dist/**/*.js"},
    preLaunchTask = "npm: build",
  },
}

-- Lua
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: ', '8086'))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end

-- Telescope integration
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
  telescope.load_extension('dap')
end

-- Load .vscode/launch.json if it exists
require('dap.ext.vscode').load_launchjs(nil, {
  ["pwa-node"] = {'javascript', 'typescript'},
  ["node2"] = {'javascript', 'typescript'},
  ["codelldb"] = {'c', 'cpp', 'rust'},
  ["lldb"] = {'c', 'cpp', 'rust'},
  ["gdb"] = {'c', 'cpp'},
})

-- Completion in DAP REPL
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-repl",
  callback = function()
    require('dap.ext.autocompl').attach()
  end
})

-- Helper functions for debugging
_G.dap_conditional_breakpoint = function()
  local condition = vim.fn.input('Breakpoint condition: ')
  require('dap').set_breakpoint(condition)
end

_G.dap_log_breakpoint = function()
  local message = vim.fn.input('Log point message: ')
  require('dap').set_breakpoint(nil, nil, message)
end

_G.dap_run_to_cursor = function()
  require('dap').run_to_cursor()
end

-- Command to view DAP log
vim.api.nvim_create_user_command('DapLogOpen', function()
  local log_path = vim.fn.stdpath('cache') .. '/dap.log'
  vim.cmd('edit ' .. log_path)
end, { desc = "Open DAP log file" })


-- Export for use in keymaps
return {
  dap = dap,
  dapui = dapui,
}