-- LSP configuration using vim.lsp.config (Neovim 0.11+)
local lsp_signature = require("lsp_signature")

-- Common on_attach function
local on_attach = function(client, bufnr)
  -- LSP signature helper
  lsp_signature.on_attach({
    bind = true,
    handler_opts = {
      border = "rounded"
    },
    -- Suppress ContentModified errors
    ignore_error = function(err, ctx, config)
      -- Match on LSP error code -32801 (ContentModified)
      if err.code == -32801 then
        return true
      end
      return false
    end
  }, bufnr)

  -- Enable inlay hints if supported
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

-- Rust
vim.lsp.config('rust_analyzer', {
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        features = 'all',
      },
      check = {
        command = 'clippy',
      },
    },
  },
})
vim.lsp.enable('rust_analyzer')

-- Python
if vim.fn.executable('pyright-langserver') == 1 then
  vim.lsp.config('pyright', {
    on_attach = on_attach,
  })
  vim.lsp.enable('pyright')
end

-- TypeScript/JavaScript
if vim.fn.executable('typescript-language-server') == 1 then
  vim.lsp.config('ts_ls', {
    on_attach = on_attach,
  })
  vim.lsp.enable('ts_ls')
end

-- Go
if vim.fn.executable('gopls') == 1 then
  vim.lsp.config('gopls', {
    on_attach = on_attach,
  })
  vim.lsp.enable('gopls')
end

-- C/C++
if vim.fn.executable('clangd') == 1 then
  vim.lsp.config('clangd', {
    on_attach = on_attach,
  })
  vim.lsp.enable('clangd')
end

-- Lua
if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
  vim.lsp.enable('lua_ls')
end

-- Copilot
vim.lsp.config('copilot', {
  filetypes = { '*' },
})
vim.lsp.enable('copilot')