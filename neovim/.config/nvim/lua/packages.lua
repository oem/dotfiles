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
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'telescope-frecency.nvim', -- improved sorting on recent files
            'popup.nvim',
            'plenary.nvim',
            'telescope-frecency.nvim',
            'telescope-fzf-native.nvim',
            'nvim-telescope/telescope-ui-select.nvim'
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
    }, { 'nvim-telescope/telescope-fzf-native.nvim' },

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
                "ibhagwan/fzf-lua",
            },
            init = function() require("config.neogit") end
        }
    },

    -- LSP
    {
        {
            'mason-org/mason-lspconfig.nvim',
            dependencies = {
                'mason-org/mason.nvim',
                'neovim/nvim-lspconfig'
            }
        },
        'nvim-lua/lsp-status.nvim'
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000,    -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
            vim.diagnostic.config({ virtual_text = false })
        end
    },
    {
        'folke/trouble.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope.nvim",
        },
        config = function() require 'trouble'.setup {} end,
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
        }
    },

    -- Completion
    { "rafamadriz/friendly-snippets" },
    {
        'l3mon4d3/luasnip',
        config = function() require("config.luasnip") end,
        dependencies = { "rafamadriz/friendly-snippets" }
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'l3mon4d3/luasnip', {
            'hrsh7th/cmp-buffer',
            'nvim-cmp',
        }, 'hrsh7th/cmp-nvim-lsp',
            { 'hrsh7th/cmp-path',         dependencies = { 'nvim-cmp' } },
            { 'hrsh7th/cmp-nvim-lua',     dependencies = { 'nvim-cmp' } },
            { 'saadparwaiz1/cmp_luasnip', dependencies = { 'nvim-cmp' } },
        },
        config = function() require("config.cmp") end,
        event = 'InsertEnter *'
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
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },

    -- haskell
    {
        'ndmitchell/ghcid',
        config = function(plugin) vim.opt.rtp:append(plugin.dir .. '/nvim') end
    },
    {
        'mrcjkb/haskell-tools.nvim',
        version = '^3', -- Recommended
        lazy = false,   -- This plugin is already lazy
        config = function() require('config.haskell-tools') end,
    },

    -- go
    {
        'fatih/vim-go',
        event = { "CmdLineEnter" },
        ft = { "go", "gomod" },
    },

    -- lua
    'tjdevries/nlua.nvim',

    -- R
    'jalvesaq/Nvim-R',

    -- html
    'mattn/emmet-vim',

    -- llvm / mlir
    'rhysd/vim-llvm',

    -- AI

    {
        "coder/claudecode.nvim",
        config = true,
        keys = {
            { "<leader>q",  nil,                              desc = "AI/Claude Code" },
            { "<leader>qc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
            { "<leader>qf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
            { "<leader>qr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
            { "<leader>qC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>qs", "<cmd>ClaudeCodeSend<cr>",        mode = "v",              desc = "Send to Claude" },
            {
                "<leader>qs",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil" },
            },
        },
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

    -- UI
    'reedes/vim-colors-pencil',
    'NLKNguyen/papercolor-theme',
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    'folke/tokyonight.nvim',
    "oem/monobold.nvim",
    'onsails/lspkind-nvim',
    'morhetz/gruvbox',
    'nvim-tree/nvim-web-devicons',
    'nyoom-engineering/oxocarbon.nvim',
    {
        'folke/noice.nvim',
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                config = function()
                    require("notify").setup(
                        {
                            background_colour = "#232323",
                            timeout = 10,
                            keep = false,
                            fps = 60,
                            render = "compact"
                        })
                end
            },
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
    {
        'windwp/windline.nvim',
        config = function()
            require('config.statusline')
        end
    },
    -- note taking
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
        },
        opts = {
            dir = "~/sync/notes",
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
            ui = {
                enable = false
            },
            new_notes_location = "notes_subdir",

            follow_url_func = function(url)
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
                -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
                -- vim.ui.open(url) -- need Neovim 0.10.0+
            end,

            follow_img_func = function(img)
                vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
                -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
            end,

            note_id_func = function(title)
                local suffix = ""
                if title ~= nil then
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                        suffix = suffix .. string.char(math.random(65, 90))
                    end
                end
                return os.date("%Y-%m-%d") .. "-" .. suffix
            end,

            mappings = {
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                -- Toggle check-boxes.
                ["<leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
                -- Smart action depending on context, either follow link or toggle checkbox.
                ["<cr>"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                },
            },
        },
    },

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
