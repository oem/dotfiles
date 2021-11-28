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
config.bind(",m", "spawn mpv --ytdl-format=best {url}")
config.bind(",M", "hint links spawn mpv {hint-url}")

c.zoom.default = "150%"
c.fonts.default_size = "16pt"
c.fonts.default_family = ["Cartograph CF Heavy"]
