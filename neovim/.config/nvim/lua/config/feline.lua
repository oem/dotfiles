local vi_mode_utils = require('feline.providers.vi_mode')

local M = { active = {}, inactive = {} }

M.active[1] = {
    {
        provider = ' ',
        hl = { fg = 'black' }
    }, {
    provider = 'vi_mode',
    hl = function()
        return {
            name = vi_mode_utils.get_mode_highlight_name(),
            fg = vi_mode_utils.get_mode_color(),
            style = 'bold'
        }
    end,
    right_sep = ' '
}, {
    provider = 'file_info',
    hl = { fg = 'white', bg = 'black', style = 'bold' },
    left_sep = {
        ' ', 'slant_left_2', { str = ' ', hl = { bg = 'black', fg = 'NONE' } }
    },
    right_sep = { 'slant_right_2', ' ' }
}, {
    provider = 'file_size',
    right_sep = {
        ' ', { str = 'slant_left_2_thin', hl = { fg = 'fg', bg = 'bg' } }
    }
}, {
    provider = 'position',
    left_sep = ' ',
    right_sep = {
        ' ', { str = 'slant_right_2_thin', hl = { fg = 'fg', bg = 'bg' } }
    }
},
    { provider = 'diagnostic_errors',   hl = { fg = 'red' } },
    { provider = 'diagnostic_warnings', hl = { fg = 'yellow' } },
    { provider = 'diagnostic_hints',    hl = { fg = 'cyan' } },
    { provider = 'diagnostic_info',     hl = { fg = 'skyblue' } }
}

M.active[2] = {
    {
        provider = 'git_branch',
        hl = { fg = 'white', bg = 'black', style = 'bold' },
        right_sep = { str = ' ', hl = { fg = 'NONE', bg = 'black' } }
    }, { provider = 'git_diff_added', hl = { fg = 'green', bg = 'black' } },
    { provider = 'git_diff_changed', hl = { fg = 'orange', bg = 'black' } }, {
    provider = 'git_diff_removed',
    hl = { fg = 'red', bg = 'black' },
    right_sep = { str = ' ', hl = { fg = 'NONE', bg = 'black' } }
}, {
    provider = 'line_percentage',
    hl = { style = 'bold' },
    left_sep = '  ',
    right_sep = ' '
}, { provider = 'scroll_bar', hl = { fg = 'gray', style = 'bold' } }
}

M.inactive[1] = {
    {
        provider = 'file_type',
        hl = { fg = 'white', bg = 'oceanblue', style = 'bold' },
        left_sep = { str = ' ', hl = { fg = 'NONE', bg = 'oceanblue' } },
        right_sep = {
            { str = ' ', hl = { fg = 'NONE', bg = 'oceanblue' } }, 'slant_right'
        }
    }, -- Empty component to fix the highlight till the end of the statusline
    {}
}

-- require('feline').setup({ theme = colors, components = M })
local ctp_feline = require('catppuccin.groups.integrations.feline')

require("feline").setup({
    components = ctp_feline.get(),
})
