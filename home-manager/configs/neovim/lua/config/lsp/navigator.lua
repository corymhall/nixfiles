
require('navigator').setup({
  on_attach = on_attach,
  default_mapping = false,
  keymaps = {
    {key="gd", func = "definition()"},
  },
  lsp = {
    -- format_on_save = false,
  }
})
