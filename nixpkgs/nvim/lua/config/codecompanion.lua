-- CodeCompanion configuration
-- Chat uses the Claude Code ACP adapter, which talks to the `claude-agent-acp`
-- binary (npm i -g @zed-industries/claude-agent-acp) and authenticates via
-- your existing `claude` CLI login. Inline edits use Gemini, matching minuet
-- (requires GEMINI_API_KEY).

require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "claude_code",
    },
    inline = {
      adapter = "gemini",
    },
  },
})

-- Keymaps
local map = vim.keymap.set
map({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "CodeCompanion chat" })
map("v", "<leader>cp", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add selection to CodeCompanion chat" })
map({ "n", "v" }, "<leader>cA", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion actions" })

-- Expand `cc` on the command line to CodeCompanion
vim.cmd([[cab cc CodeCompanion]])
