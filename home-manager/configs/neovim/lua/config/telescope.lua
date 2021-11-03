-- Telescope
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')
local trouble = require('trouble.providers.telescope')
local themes = require "telescope.themes"

require('telescope').setup {
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",

    winblend = 0,

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    color_devicons = true,
    sorting_strategy = "descending",
    -- file_sorter = sorters.get_fzy_sorter,
    file_previewer = previewers.vim_buffer_cat.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,

    file_ignore_patterns = {
      "node_modules",
      "vendor",
      "dist",
      ".git",
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k"] = actions.move_selection_previous,
        ["<C-sq"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k"] = actions.move_selection_previous,
        ["<C-sq"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-t>"] = trouble.open_with_trouble,
      }
    },
    extensions = {
      fzf = {
        override_file_sorter = true,
        override_generic_sorter = true,
      }
    },
  }
}

require('telescope').load_extension 'fzf'
require('telescope').load_extension('git_worktree')
require('telescope').load_extension("gh")
local M = {}

function M.fd()
  local opts = themes.get_ivy { hidden = true }
  require("telescope.builtin").fd(opts)
end

function M.git_files()
  require("telescope.builtin").git_files(themes.get_ivy {
    hidden = true,
    cwd = vim.fn.expand "%:p:h",
    winblend = 10,
    border = true,
    shorten_path = false,
  })
end


--telescope mappings
--vim.api.nvim_set_keymap('n', '<leader>tt', [[<cmd>lua require("telescope.builtin").find_files()<cr>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tt', [[<cmd>lua require("config.telescope").find_files()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fd', [[<cmd>lua require("config.telescope").fd()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require("telescope.builtin").file_browser()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgf', [[<cmd>lua require("config.telescope").git_files()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ta', [[<cmd>lua require("telescope.builtin").live_grep()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgr', [[<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgs', [[<cmd>lua require("telescope.builtin").git_status()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgb', [[<cmd>lua require("telescope.builtin").git_branches()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgbc', [[<cmd>lua require("telescope.builtin").git_bcommits()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgc', [[<cmd>lua require("telescope.builtin").git_commits()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ';', [[<cmd>lua require("telescope.builtin").buffers({ ignore_current_buffer = true, sort_mru = true })<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wo', [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgw', [[<cmd>lua require("telescope").extensions.git_worktree.git_worktrees()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tgm', [[<cmd>lua require("telescope").extensions.git_worktree.create_git_worktree()<cr>]], { noremap = true, silent = true })


return M
