local sources = {
  require('null-ls').builtins.diagnostics.eslint_d,
  require('null-ls').builtins.formatting.eslint_d.with({
    filetypes = { "typescript", "javascript" },
  }),
  require('null-ls').builtins.diagnostics.flake8,
}


require('null-ls').config({
  sources = sources
})
