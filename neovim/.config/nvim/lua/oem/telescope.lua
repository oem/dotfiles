local M = {}
M.find_notes = function()
    require('telescope.builtin').find_files {
        prompt_title = 'notes>',
        cwd = '~/sync/notes'
    }
end

M.search_notes = function()
    require('telescope.builtin').live_grep {
        prompt_title = 'notes>',
        cwd = '~/sync/notes'
    }
end

return M
