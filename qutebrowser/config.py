config.load_autoconfig()
config.bind(',m', 'spawn mpv {url}')
config.bind(',M', 'hint links spawn mpv {hint-url}')
config.set("colors.webpage.darkmode.enabled", True)
