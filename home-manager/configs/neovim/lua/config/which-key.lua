local wk = require 'which-key'
wk.setup {
  window = {
    border = { '─', '─', '─', ' ', ' ', ' ', ' ', ' ' }, -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 0, 0, 1, 0 }, -- extra window padding [top, right, bottom, left]
  },
}

wk.register({
  f = {
    name = 'file', -- optional group name
  },
  b = {
    name = 'buffer', -- optional group name
  },
  n = {
    name = 'neovim', -- optional group name
  },
  s = {
    name = 'search', -- optional group name
  },
  w = {
    name = 'workspace', -- optional group name
  },
  q = {
    name = 'quickfix', -- optional group name
  },
  g = {
    name = 'git', -- optional group name
  },
  h = {
    name = 'help/hunks', -- optional group name
  },
  ['?'] = 'which_key_ignore',
  [';'] = 'which_key_ignore',
  [','] = 'which_key_ignore',
  ['<space>'] = 'which_key_ignore',
  ['.'] = 'which_key_ignore',
}, {
  prefix = '<leader>',
})

-- map :W to :w (helps which-key issue)
vim.cmd [[ command! W  execute ':w' ]]
