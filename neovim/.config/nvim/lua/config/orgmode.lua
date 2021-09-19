require('orgmode').setup({
	org_agenda_files = ('~/sync/notes/**/*'),
	org_default_notes_file = '~/sync/notes/notes.org',
	org_todo_keywords = { 'TODO(t)', 'NEXT(n)', '|', 'DONE(d)' },
	org_hide_leading_stars = true,
	org_indent_mode = 'noindent',
	org_agenda_templates = {
		t = { description = 'task', template = '* TODO %?\n%u' },
		n = { description = 'fleeting note', template = '* %?\n%U\n%a' },
	}
})
