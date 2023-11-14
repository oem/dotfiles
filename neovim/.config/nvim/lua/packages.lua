local fn = vim.fn
local execute = vim.api.nvim_command

-- Package Manager
-- Bootstrapping
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    execute 'packadd packer.nvim'
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
                'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
                'telescope-frecency.nvim', -- improved sorting on recent files
                'telescope-fzf-native.nvim'
            },
            wants = {
                'popup.nvim', 'plenary.nvim', 'telescope-frecency.nvim',
                'telescope-fzf-native.nvim'
            },
            setup = [[require('config.telescope_setup')]],
            config = [[require('config.telescope')]],
            cmd = 'Telescope',
            module = 'telescope'
        }, {
        'nvim-telescope/telescope-frecency.nvim',
        after = 'telescope.nvim',
        requires = 'tami5/sql.nvim'
    }, { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }

    -- Git
    use {
        {
            'tpope/vim-fugitive',
            cmd = { 'Git', 'Git status', 'Git blame', 'Git push', 'Git pull' }
        }, {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = [[require('config.gitsigns')]]
    }, {
        'NeogitOrg/neogit',
        cmd = 'Neogit',
        config = function()
            require('neogit').setup { disable_commit_confirmation = true }
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "sindrets/diffview.nvim",
            "ibhagwan/fzf-lua"
        },
        setup = [[require('config.neogit')]]
    }, { use 'sindrets/diffview.nvim' }
    }

    -- LSP
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'nvim-lua/lsp-status.nvim',
        'nvim-lua/lsp_extensions.nvim'
    }

    use {
        'folke/trouble.nvim',
        requires = "kyazdani42/nvim-web-devicons",
        setup = [[require('config.trouble_setup')]],
        config = function() require 'trouble'.setup {} end
    }

    use {
        'ray-x/lsp_signature.nvim',
        config = function() require 'lsp_signature'.setup() end
    }

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip', {
            'hrsh7th/cmp-buffer',
            after = 'nvim-cmp',
            config = [[require('config.luasnip')]],
            setup = [[require('config.luasnip_setup')]]
        }, 'hrsh7th/cmp-nvim-lsp',
            { 'hrsh7th/cmp-path',         after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua',     after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        },
        config = [[require('config.cmp')]],
        event = 'InsertEnter *'
    }

    -- Linting and fixing
    use 'dense-analysis/ale'

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'leoluz/nvim-dap-go'
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap",
        },
        config = [[require('config.dap')]]
    }

    -- Highlights
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground'
        },
        config = [[require('config.treesitter')]],
        run = ':TSUpdate'
    }

    -- Some additional functionality on top of lsp
    -- rust
    use 'simrat39/rust-tools.nvim'

    -- haskell
    use { 'ndmitchell/ghcid', rtp = 'plugins/nvim' }

    -- python
    use {
        'HallerPatrick/py_lsp.nvim',
        config = function() require('py_lsp').setup {} end
    }

    -- lua
    use 'tjdevries/nlua.nvim'

    -- R
    use 'jalvesaq/Nvim-R'

    -- llvm / mlir
    use 'rhysd/vim-llvm'

    -- repl
    use {
        'Olical/conjure',
        ft = 'racket'
    }

    -- Commenting
    use 'tomtom/tcomment_vim'

    -- Editing
    use 'tpope/vim-surround'
    use 'RRethy/nvim-align'

    -- Moving
    use 'tpope/vim-unimpaired'
    use 'christoomey/vim-tmux-navigator'

    -- encryption
    use 'jamessan/vim-gnupg'

    -- html
    use {
        'mattn/emmet-vim',
        config = function()
            vim.cmd([[let g:user_emmet_leader_key = "<C-E>"]])
        end
    }

    -- UI
    use 'reedes/vim-colors-pencil'
    use 'NLKNguyen/papercolor-theme'
    use 'folke/tokyonight.nvim'
    use 'onsails/lspkind-nvim'
    use 'morhetz/gruvbox'
    use "nvim-tree/nvim-web-devicons"
    -- show trailing whitespace
    use 'ntpeters/vim-better-whitespace'

    -- autobalancing delimiters
    use {
        'windwp/nvim-autopairs',
        after = "nvim-cmp",
        config = [[require('config.autopairs')]]
    }

    -- show indentation levels
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup()
        end
    }

    -- Statusline
    use { 'freddiehaddad/feline.nvim', config = [[require('config.feline')]] }

    use {
        "oem/arachne.nvim",
        config = function()
            local dir = os.getenv("HOME") .. "/sync/notes"
            require('arachne').setup { notes_directory = dir }
        end,
        setup = function()
            vim.keymap.set('n', '<leader>nn',
                function() return require('arachne').new() end)
            vim.keymap.set('n', '<leader>nr',
                function()
                    return require('arachne').rename()
                end)
        end
    }
end)
