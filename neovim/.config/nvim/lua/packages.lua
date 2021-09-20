local fn = vim.fn

-- Package Manager
-- Bootstrapping
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- Packages
require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Search
  use {
    {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'telescope-frecency.nvim', -- improved sorting on recent files
        'telescope-fzf-native.nvim',
      },
      wants = {
        'popup.nvim',
        'plenary.nvim',
        'telescope-frecency.nvim',
        'telescope-fzf-native.nvim',
      },
      setup = [[require('config.telescope_setup')]],
      config = [[require('config.telescope')]],
      cmd = 'Telescope',
      module = 'telescope',
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      after = 'telescope.nvim',
      requires = 'tami5/sql.nvim',
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
    },
  }

  -- Git
  use {
    { 'tpope/vim-fugitive', cmd = { 'Git', 'Git status', 'Git blame', 'Git push', 'Git pull' } },
    {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('config.gitsigns')]],
    },
    {
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      config = function()
        require('neogit').setup {
          disable_commit_confirmation = true
        }
      end,
      setup = [[require('config.neogit')]]
    },
  }

  -- Completion and linting
  use {
    'neovim/nvim-lspconfig',
    'nvim-lua/lsp-status.nvim',
    'nvim-lua/lsp_extensions.nvim',
  }

	use {
    'folke/trouble.nvim',
		config = function()
			require 'trouble'.setup({})
		end
	}

	use {
    'ray-x/lsp_signature.nvim',
		config = function()
			require 'lsp_signature'.setup()
		end
	}

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    config = [[require('config.cmp')]],
    event = 'InsertEnter *',
  }

  -- Linting and fixing
  use 'dense-analysis/ale'

  -- Highlights
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
			'nvim-treesitter/playground',
    },
		config = [[require('config.treesitter')]],
    run = ':TSUpdate',
  }

	-- Some additional functionality on top of the lsp
	use {
		'simrat39/rust-tools.nvim',
		config=function()
			require('rust-tools').setup({})
		end
	}

  -- Commenting
  use 'tomtom/tcomment_vim'

  -- Editing
  use 'tpope/vim-surround'

  -- Moving
  use 'tpope/vim-unimpaired'
  use 'christoomey/vim-tmux-navigator'

	-- encryption
	use 'jamessan/vim-gnupg'

  -- UI
  use 'reedes/vim-colors-pencil'
	use 'NLKNguyen/papercolor-theme'

	-- show trailing whitespace
	use 'ntpeters/vim-better-whitespace'

	-- autobalancing delimiters
	use {
		'windwp/nvim-autopairs',
		after = "nvim-cmp",
		config = function()
			require('nvim-autopairs').setup({})
		end,
	}

-- show indentation levels
use {
	'lukas-reineke/indent-blankline.nvim',
	config = function()
		require('indent_blankline').setup{
			show_end_of_line = true,
			space_char_blankline = " ",
			show_current_context = false,
		}
	end
}

  -- Statusline
  use {
    'famiu/feline.nvim',
    config = function()
      require('feline').setup({ preset = 'noicon' })
    end
  }

	use {
		'kristijanhusak/orgmode.nvim',
		config = [[require('config.orgmode')]],
	}

end)

