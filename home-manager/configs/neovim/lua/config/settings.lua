vim.cmd 'filetype plugin indent on'
vim.o.completeopt = 'menuone,noselect'
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.hidden = true -- enable background buffers
vim.o.ignorecase = true -- ignore case
vim.o.joinspaces = false -- non double spaces with join
vim.o.list = true -- show some invisible characters
vim.o.number = true -- show line numbers
vim.o.scrolloff = 4 -- lines of context
vim.o.shiftround = true -- round indent
vim.o.shiftwidth = 2 --size of indent
vim.o.sidescrolloff = 8 -- columns of context
vim.o.smartcase = true                -- Do not ignore case with capitals
vim.o.smartindent = true              -- Insert indents automatically
vim.o.splitbelow = true               -- Put new windows below current
vim.o.splitright = true               -- Put new windows right of current
vim.o.tabstop = 2                     -- Number of spaces tabs count for
vim.o.termguicolors = true            -- True color support
--vim.o.wildmode = {'list', 'longest'}  -- Command-line completion mode
vim.o.wrap = false                    -- Disable line wrap
vim.o.mouse = 'a'
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

vim.g.clipboard = {
  name = 'clipboard',
  copy = {
    ['+'] = 'tmux load-buffer -w -',
    ['*'] = 'tmux load-buffer -w -'
  },
  paste = {
    ['+'] = 'tmux save-buffer -',
    ['*'] = 'tmux save-buffer -'
  },
  cache_enabled = 1
}

vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'

vim.cmd 'colorscheme everforest'

--Add spellchecking
vim.cmd [[ autocmd FileType gitcommit setlocal spell ]]
vim.cmd [[ autocmd FileType markdown setlocal spell ]]

--Remap comma as leader key
vim.api.nvim_set_keymap('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','
