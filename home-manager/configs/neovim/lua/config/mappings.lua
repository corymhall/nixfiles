vim.api.nvim_set_keymap('n', '<leader>jb', [[<cmd>lua require("config.worktree").execute(vim.loop.cwd(), "just-build")<cr>]], { noremap = true, silent =true })
vim.api.nvim_set_keymap('n', '<leader>yt', [[<cmd>lua require("config.worktree").yarn_test()<cr>]], { noremap = true, silent =true })


-- Copy to clipboard in normal, visual, select and operator modes
vim.api.nvim_set_keymap('', '<leader>c', '"+y', { noremap = true, silent = true })

-- insert new line in  insert mode
vim.api.nvim_set_keymap('i', '<C-l>', "<C-O>o", { noremap = true, silent = true })


-- vim-maximizer shortcuts
vim.api.nvim_set_keymap('', '<leader>m', ':MaximizerToggle<CR>', { noremap = true, silent = true })

-- Fugitive shortcuts
-- vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add %:p<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gg', ':GBrowse<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ge', ':Gedit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':silent! Glog<CR>:bot copen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gm', ':Gmove<Space>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>go', ':Git checkout<Space>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gfa', ':Git fetch --all<CR>', { noremap = true, silent = true })


-- Managing quickfix list
vim.api.nvim_set_keymap('n', '<leader>qo', ':copen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qq', ':cclose<CR>', { noremap = true, silent = true })
vim.cmd [[autocmd FileType qf nnoremap <buffer> q :cclose<CR>]]

-- Managing buffers
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })
--
-- Neovim management
vim.api.nvim_set_keymap('n', '<leader>nu', ':PackerUpdate<CR>', { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<M-j>', ':MultipleCursorsFind <C-R>/<CR>', { noremap = true, silent = true })
