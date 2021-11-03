local execute = vim.api.nvim_command

--------------------PLUGINS--------------------------------------
-- Auto install packer if not exists
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
  ]],
  false
)

-- install plugins
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  -- general
  use 'tpope/vim-fugitive' -- git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'terryma/vim-multiple-cursors'
  use 'jiangmiao/auto-pairs'
  use 'szw/vim-maximizer'
  -- Add git related info in the signs columns and popups
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("config.gitsigns")
    end,
  }
  use {
    'hoob3rt/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = { theme = 'everforest' }
      }
    end
  }
  use {
    'folke/zen-mode.nvim',
    config = function()
      require("zen-mode").setup{}
    end
  }
  use {
    'folke/which-key.nvim',
    config = function()
      require('config.which-key')
    end
  }
  use 'vimwiki/vimwiki'

  -- colorschemes
  use {
    'arcticicestudio/nord-vim',
    config = function()
      require("config.nord")
    end,
  }
  use {
    'sainnhe/everforest',
    config = function()
      require("config.everforest")
    end,
  }
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require("config.devicons")
    end
  }


  -- filebrowser
  use {
    'tamago324/lir.nvim',
    config = function()
      require("config.lir")
    end
  }
  use 'tamago324/lir-git-status.nvim'

  -- languages
  use 'LnL7/vim-nix'
  use 'hashivim/vim-terraform'


  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require("config.treesitter")
    end,
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'


  -- completion
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("config.cmp")
    end,
  }
  use 'hrsh7th/cmp-nvim-lsp'


  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'ThePrimeagen/git-worktree.nvim'}},
    config = function()
      require("config.telescope")
    end,
  }
  use {'nvim-telescope/telescope-github.nvim'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      require("config.worktree")
    end,
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    wants = { "null-ls.nvim", "nvim-lspfuzzy", "lsp_signature.nvim" },
    config = function()
      require("config.lsp")
    end,
    requires = { "null-ls.nvim", "nvim-lspfuzzy", "lsp_signature.nvim" },
  }
  use {
    'ray-x/go.nvim',
    requires = {{'nneovim/nvim-lspconfig'}},
    config = function()
      require('config.go')
    end
  }
  use 'ojroques/nvim-lspfuzzy'
  use 'ray-x/lsp_signature.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
  use {
    'ray-x/navigator.lua',
    requires = {'ray-x/guihua.lua'},
  }
  use 'folke/lsp-colors.nvim'
  use {
    'folke/trouble.nvim',
    config = function()
      require("config.trouble")
    end
  }
  use 'onsails/lspkind-nvim'
end)

---------------------Settings---------------------------------------------------
require('config.settings')


-----------------------------Mappings-----------------------------------------------------------------------------
require('config.mappings')
