-- Completion configuration

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Setup completion
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "minuet" },
    { name = "path" },
    { name = "buffer", keyword_length = 3 },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      max_width = 50,
      ellipsis_char = "...",
      menu = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        minuet = "[AI]",
        buffer = "[Buf]",
        path = "[Path]",
      },
    }),
  },
  experimental = {
    ghost_text = true, -- Show preview of completion
  },
  performance = {
    debounce = 60,
    throttle = 30,
  },
})

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()