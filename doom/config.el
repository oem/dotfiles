;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;; Code:
(setq doom-font (font-spec :family "Tamsyn" :size 20))
(setq doom-big-font (font-spec :family "Cartograph Mono CF Heavy" :size 26))
(setq doom-theme 'doom-Iosvkem)
(toggle-frame-fullscreen)
(global-visual-line-mode)
(toggle-scroll-bar -1)

;; exit insert mode by pressing jj
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.2)
;;; config.el ends here
