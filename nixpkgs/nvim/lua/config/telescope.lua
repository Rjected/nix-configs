-- Telescope configuration

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 120,
      },
      horizontal = {
        preview_width = 0.55,
      },
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-u>"] = false, -- Clear prompt with Ctrl-U
        ["<C-d>"] = actions.delete_buffer,
      },
    },
    file_ignore_patterns = { "node_modules", ".git/", "dist/" },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = { "--hidden" },
    },
  },
})

-- Load extensions
telescope.load_extension("file_browser")
telescope.load_extension("bookmarks")
telescope.load_extension("fzf")

-- Harpoon telescope integration
local harpoon = require("harpoon")
harpoon:setup()

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })