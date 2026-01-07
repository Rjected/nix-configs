-- Helper for better Rust debugging

local M = {}

-- Create or update .cargo/config.toml for better debugging
function M.setup_cargo_debug()
  local cargo_dir = vim.fn.getcwd() .. "/.cargo"
  local config_file = cargo_dir .. "/config.toml"
  
  -- Check if we're in a Rust project
  if vim.fn.filereadable("Cargo.toml") == 0 then
    vim.notify("Not in a Rust project (no Cargo.toml found)", vim.log.levels.WARN)
    return
  end
  
  -- Create .cargo directory if it doesn't exist
  if vim.fn.isdirectory(cargo_dir) == 0 then
    vim.fn.mkdir(cargo_dir, "p")
  end
  
  -- Debug profile configuration for better debugging
  local debug_config = [[
[profile.dev]
opt-level = 0      # No optimization
debug = true       # Full debug info
overflow-checks = true
incremental = true
codegen-units = 256
split-debuginfo = "unpacked"  # For macOS

[profile.dev.package."*"]
opt-level = 0      # No optimization for dependencies too
debug = true
]]
  
  -- Check if config exists and has our debug settings
  local needs_update = true
  if vim.fn.filereadable(config_file) == 1 then
    local existing = table.concat(vim.fn.readfile(config_file), "\n")
    if existing:find("profile%.dev") then
      vim.notify("Debug profile already configured in .cargo/config.toml", vim.log.levels.INFO)
      needs_update = false
    end
  end
  
  if needs_update then
    -- Append to existing config or create new
    vim.fn.writefile(vim.split(debug_config, "\n"), config_file, "a")
    vim.notify("Added debug profile to .cargo/config.toml - rebuild with 'cargo clean && cargo build'", vim.log.levels.INFO)
  end
end

-- Build with best debug settings
function M.cargo_build_debug()
  vim.notify("Building with full debug info...", vim.log.levels.INFO)
  local cmd = "CARGO_PROFILE_DEV_DEBUG=true CARGO_PROFILE_DEV_OPT_LEVEL=0 cargo build"
  vim.fn.system(cmd)
  vim.notify("Debug build complete", vim.log.levels.INFO)
end

-- Check if binary has debug symbols
function M.check_debug_symbols(binary_path)
  if not binary_path or binary_path == "" then
    binary_path = vim.fn.input("Path to binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
  end
  
  -- On macOS, use dwarfdump or nm
  local check_cmd = "nm -pa " .. binary_path .. " 2>/dev/null | grep -c ' N '"
  local result = vim.fn.system(check_cmd)
  
  if tonumber(result) and tonumber(result) > 0 then
    vim.notify("Binary has debug symbols ✓", vim.log.levels.INFO)
    return true
  else
    vim.notify("Warning: Binary may lack debug symbols or variable names", vim.log.levels.WARN)
    return false
  end
end

-- Add commands
vim.api.nvim_create_user_command('DapRustSetup', function()
  M.setup_cargo_debug()
end, { desc = "Setup Cargo for better Rust debugging" })

vim.api.nvim_create_user_command('DapRustBuild', function()
  M.cargo_build_debug()
end, { desc = "Build Rust with full debug info" })

vim.api.nvim_create_user_command('DapRustCheck', function(opts)
  M.check_debug_symbols(opts.args)
end, { desc = "Check if binary has debug symbols", nargs = "?" })

return M