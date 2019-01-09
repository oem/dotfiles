;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq doom-font (font-spec :family "Tamsyn" :size 20))
(toggle-frame-fullscreen)
;; exit insert mode by pressing jj
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.2)
