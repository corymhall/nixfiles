require('trouble').setup {
  use_lsp_diagnostic_signs = false,
  ['rg'] = {
    cmd = "rg",
    -- default args
    args = {
      -- '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      "-g '!{.git,vendor,node_modules}'"
    },
    options = {
      ['ignore-case'] = {
        value = '--ignore-case',
        icon="[I]",
        desc="ignore case"
      },
      ['hidden'] = {
        value="--hidden",
        desc="hidden file",
        icon="[H]"
      },
    }
  }
}
--
--Trouble
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xw', '<cmd>Trouble lsp_workspace_diagnostics<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xd', '<cmd>Trouble lsp_document_diagnostics<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gR', '<cmd>Trouble lsp_references<cr>', { noremap = true, silent = true })
