local actions = require('lir.actions')
local clipboard_actions = require('lir.clipboard.actions')

require('lir').setup{
  show_hidden_files = true,
  devicons_enable = true,
  mappings =  {
    ['CR'] = actions.edit,
    ['o'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['-'] = actions.up,
    ['q'] = actions.quit,

    ['a'] = actions.newfile,
    ['d'] = actions.mkdir,
    ['r'] = actions.rename,
    ['@'] = actions.cd,
    ['y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['d'] = actions.delete,

    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  }
}

--vim.api.nvim_set_keymap("n", "<leader>d", ":edit %:h<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>d", [[<cmd>lua require('lir.float').toggle()<CR>]], { noremap = true })

