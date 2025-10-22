from qutebrowser.api import interceptor


def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()


interceptor.register(filter_yt)

config.load_autoconfig()
config.bind(",m", "spawn mpv --hwdec=auto --ytdl-format=best {url}")
config.bind(",M", "hint links spawn mpv --hwdec=auto {hint-url}")

# darkmode
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# completion
c.colors.completion.even.bg = "#000000"
c.colors.completion.odd.bg = "#000000"
c.colors.completion.category.bg = "#FF4500"
c.colors.completion.category.fg = "#000000"

c.zoom.default = "150%"
c.fonts.default_size = "16pt"
c.fonts.default_family = ["Berkeley Mono"]
c.fonts.web.family.fixed = "Berkeley Mono"
c.auto_save.session = True
c.content.blocking.enabled = True
