local M = {}

M.find_notes = function()
    require('telescope.builtin').find_files {
        prompt_title = '<notes::files>',
        cwd = '~/sync/notes'
    }
end

M.search_notes = function()
    require('telescope.builtin').live_grep {
        prompt_title = '<notes::search>',
        cwd = '~/sync/notes'
    }
end

return M
