-- Minuet AI configuration with Gemini

require('minuet').setup({
  provider = 'gemini',
  providers = {
    gemini = {
      model = 'gemini-2.5-flash-lite-preview-06-17',
    },
  },
  -- Enable both virtual text and completion menu
  show_on_demand_call_signature = true,
  show_on_cursor_hold_call_signature = true,
  show_on_demand_completion = true,
  show_on_cursor_hold_completion = true,
  show_on_completion_menu = true,  -- This enables nvim-cmp integration

  -- Trigger settings to show completions more often
  debounce = 200,  -- Reduced from 500ms to trigger faster
  throttle = 500,  -- Reduced from 1000ms
  auto_trigger_ignore_ft = {},  -- Don't ignore any filetypes
  trigger_chars = {  -- Trigger on more characters
    ".", ":", "(", "'", '"', "[", ",", "#", "*", "@", "|", "=", "{", "/", "\\", " ", "+", "-"
  },

  optional = {
    generationConfig = {
      maxOutputTokens = 256,
      -- When using `gemini-2.5-flash`, it is recommended to entirely
      -- disable thinking for faster completion retrieval.
      thinkingConfig = {
        thinkingBudget = 0,
      },
    },
  },

  -- Virtual text settings
  virtual_text = {
    enabled = true,
    hl_group = "Comment",
  },
})