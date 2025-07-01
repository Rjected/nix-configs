-- LSP configuration

local lspconfig = require("lspconfig")
local lsp_signature = require("lsp_signature")

-- LSP handlers with borders
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = {
      { "╭", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╮", "FloatBorder" },
      { "│", "FloatBorder" },
      { "╯", "FloatBorder" },
      { "─", "FloatBorder" },
      { "╰", "FloatBorder" },
      { "│", "FloatBorder" },
    },
  }),
}

-- Diagnostic configuration
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)

-- Suppress server cancelled request errors
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end

-- Common on_attach function
local on_attach = function(client, bufnr)
  lsp_signature.on_attach({
    bind = true,
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)
end

-- Rust workspace root detection (copied from rust-tools)
local function get_rust_root_dir(filename)
  local lspconfig_utils = require("lspconfig.util")
  local fname = filename or vim.api.nvim_buf_get_name(0)
  local cargo_crate_dir = lspconfig_utils.root_pattern("Cargo.toml")(fname)
  local cmd = { "cargo", "metadata", "--no-deps", "--format-version", "1" }
  
  if cargo_crate_dir ~= nil then
    cmd[#cmd + 1] = "--manifest-path"
    cmd[#cmd + 1] = lspconfig_utils.path.join(cargo_crate_dir, "Cargo.toml")
  end
  
  local cargo_metadata = ""
  local cm = vim.fn.jobstart(cmd, {
    on_stdout = function(_, d, _)
      cargo_metadata = table.concat(d, "\n")
    end,
    stdout_buffered = true,
  })
  
  if cm > 0 then
    cm = vim.fn.jobwait({ cm })[1]
  else
    cm = -1
  end
  
  local cargo_workspace_dir = nil
  if cm == 0 then
    cargo_workspace_dir = vim.fn.json_decode(cargo_metadata)["workspace_root"]
  end
  
  return cargo_workspace_dir
    or cargo_crate_dir
    or lspconfig_utils.root_pattern("rust-project.json")(fname)
    or lspconfig_utils.find_git_ancestor(fname)
end

-- Rust analyzer setup
lspconfig.rust_analyzer.setup({
  cmd = { "/Users/dan/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
  handlers = handlers,
  on_attach = on_attach,
  root_dir = get_rust_root_dir,
})

-- C/C++ setup
lspconfig.ccls.setup({
  lsp = {
    format_on_save = false,
  },
  handlers = handlers,
  on_attach = on_attach,
})

-- Go setup
lspconfig.gopls.setup({
  handlers = handlers,
  on_attach = on_attach,
})

-- EVM Assembly LSP setup
local configs = require("lspconfig.configs")
if not configs.evm_asm_lsp then
  configs.evm_asm_lsp = {
    default_config = {
      cmd = { "evm-asm-lsp" },
      filetypes = { "evmasm", "eas", "evm" },
      root_dir = lspconfig.util.root_pattern(".git", "Makefile", "package.json"),
      settings = {},
    },
  }
end

lspconfig.evm_asm_lsp.setup({
  handlers = handlers,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    on_attach(client, bufnr)
  end,
})