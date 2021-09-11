from qutebrowser.api import interceptor

def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (url.host() == 'www.youtube.com' and
            url.path() == '/get_video_info' and
            '&adformat=' in url.query()):
        info.block()

interceptor.register(filter_yt)

config.load_autoconfig()
config.bind(',m', 'spawn mpv {url}')
config.bind(',M', 'hint links spawn mpv {hint-url}')
config.set("fonts.tabs.selected",'14pt default_family')
config.set("fonts.tabs.unselected",'14pt default_family')
config.set("fonts.default_size",'14pt')
config.set("fonts.web.size.default_fixed", 16)
config.set("fonts.default_family", "TerminessTTF Nerd Font")
