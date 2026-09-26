P = function(v)
	print(vim.inspect(v))
	return v
end

GetClipboard = function()
	if vim.fn.has("mac") == 1 then
		return {
			name = "pbcopy",
			copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
			paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
			cache_enabled = 0,
		}
	end

	if vim.fn.has("wsl") == 1 then
		-- swap this for xclip/xsel/wl-copy if your earlier `time` test showed
		-- one of those beating win32yank on your specific WSLg setup
		return {
			name = "win32yank",
			copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
			paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
			cache_enabled = 0,
		}
	end

	-- native Linux (Arch etc.) — distinguish Wayland vs X11
	if vim.env.WAYLAND_DISPLAY then
		return {
			name = "wl-clipboard",
			copy = { ["+"] = "wl-copy --type text/plain", ["*"] = "wl-copy --primary --type text/plain" },
			paste = { ["+"] = "wl-paste --no-newline", ["*"] = "wl-paste --no-newline --primary" },
			cache_enabled = 0,
		}
	end

	return {
		name = "xclip",
		copy = { ["+"] = "xclip -selection clipboard", ["*"] = "xclip -selection primary" },
		paste = { ["+"] = "xclip -selection clipboard -o", ["*"] = "xclip -selection primary -o" },
		cache_enabled = 1,
	}
end
