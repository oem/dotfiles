-- Package Manager
-- Bootstrapping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Packages
require('lazy').setup({
    -- Search
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'telescope-frecency.nvim', -- improved sorting on recent files
            'telescope-fzf-native.nvim',
            'popup.nvim',
            'plenary.nvim',
            'telescope-frecency.nvim',
            'telescope-fzf-native.nvim'
        },
        init = function() require("config.telescope_setup") end,
        config = function()
            require("config.telescope")
        end,
        cmd = 'Telescope',
    },
    {
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = 'tami5/sql.nvim'
    }, { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- Git
    {
        {
            'tpope/vim-fugitive',
            cmd = { 'Git', 'Git status', 'Git blame', 'Git push', 'Git pull' }
        }, {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('config.gitsigns')
        end,
    },
        {
            'NeogitOrg/neogit',
            cmd = 'Neogit',
            config = function()
                require('neogit').setup { disable_commit_confirmation = true }
            end,
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
                "sindrets/diffview.nvim",
                "ibhagwan/fzf-lua"
            },
            init = function() require('config.neogit') end
        }
    },

    -- LSP
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'nvim-lua/lsp-status.nvim',
        'nvim-lua/lsp_extensions.nvim'
    },

    {
        'folke/trouble.nvim',
        dependencies = "nvim-tree/nvim-web-devicons",
        init = function() require('config.trouble_setup') end,
        config = function() require 'trouble'.setup {} end
    },

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip', {
            'hrsh7th/cmp-buffer',
            'nvim-cmp',
            config = function() require("config.luasnip") end,
            init = function() require("config.luasnip_setup") end,
        }, 'hrsh7th/cmp-nvim-lsp',
            { 'hrsh7th/cmp-path',         dependencies = { 'nvim-cmp' } },
            { 'hrsh7th/cmp-nvim-lua',     dependencies = { 'nvim-cmp' } },
            { 'saadparwaiz1/cmp_luasnip', dependencies = { 'nvim-cmp' } },
        },
        config = function() require("config.cmp") end,
        event = 'InsertEnter *'
    },

    -- Linting and fixing
    'dense-analysis/ale',

    -- Debugging
    'mfussenegger/nvim-dap',
    'leoluz/nvim-dap-go',
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = [[require('config.dap')]]
    },

    -- Highlights
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground'
        },
        config = function() require('config.treesitter') end,
        build = ':TSUpdate'
    },

    -- Some additional functionality on top of lsp
    -- rust
    'simrat39/rust-tools.nvim',

    -- haskell
    { 'ndmitchell/ghcid',                         config = function(plugin) vim.opt.rtp:append(plugin.dir .. '/nvim') end },

    -- python
    {
        'HallerPatrick/py_lsp.nvim',
        config = function() require('py_lsp').setup {} end
    },

    -- lua
    'tjdevries/nlua.nvim',

    -- R
    'jalvesaq/Nvim-R',

    -- llvm / mlir
    'rhysd/vim-llvm',

    -- repl
    {
        'Olical/conjure',
        ft = 'racket'
    },

    -- Commenting
    'tomtom/tcomment_vim',

    -- Editing
    'tpope/vim-surround',
    'RRethy/nvim-align',

    -- Moving
    'tpope/vim-unimpaired',
    'christoomey/vim-tmux-navigator',

    -- encryption
    'jamessan/vim-gnupg',

    -- html
    {
        'mattn/emmet-vim',
        config = function()
            vim.cmd([[let g:user_emmet_leader_key = "<C-E>"]])
        end
    },

    -- UI
    'reedes/vim-colors-pencil',
    'NLKNguyen/papercolor-theme',
    { "catppuccin/nvim",           name = "catppuccin",                             priority = 1000 },
    'folke/tokyonight.nvim',
    'onsails/lspkind-nvim',
    'morhetz/gruvbox',
    "nvim-tree/nvim-web-devicons",

    {
        'folke/noice.nvim',
        dependencies = {
            "MunifTanjim/nui.nvim",
            { "rcarriga/nvim-notify", config = function() require("notify").setup({ background_colour = "#000000" }) end },
        },
        config = function()
            require('noice').setup({
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            })
        end
    },

    -- show trailing whitespace
    'ntpeters/vim-better-whitespace',

    -- autobalancing delimiters
    {
        'windwp/nvim-autopairs',
        dependencies = { "nvim-cmp" },
        config = function() require('config.autopairs') end
    },

    -- show indentation levels
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('ibl').setup()
        end
    },

    -- Statusline
    { 'freddiehaddad/feline.nvim', config = function() require('config.feline') end },

    -- note taking
    {
        "oem/arachne.nvim",
        config = function()
            local dir = os.getenv("HOME") .. "/sync/notes"
            require('arachne').setup { notes_directory = dir }
        end,
        init = function()
            vim.keymap.set('n', '<leader>nn',
                function() return require('arachne').new() end)
            vim.keymap.set('n', '<leader>nr',
                function()
                    return require('arachne').rename()
                end)
        end
    },
})
