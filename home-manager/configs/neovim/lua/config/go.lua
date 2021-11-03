require('go').setup({
  -- goimport = "goimport",
  gofmt = "gofumpt",
  lsp_cfg = true,
})

vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
