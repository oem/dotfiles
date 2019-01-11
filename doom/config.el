;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;; Code:
(setq doom-font (font-spec :family "Tamsyn" :size 20))
(setq doom-variable-pitch-font (font-spec :family "Cartograph Mono CF Heavy" :size 26))

(cond
 ((string-equal system-type "darwin")
  (setq doom-font (font-spec :family "Cartograph Mono CF" :size 14))
  (setq doom-variable-pitch-font (font-spec :family "Avenir Next LT Pro" :size 24))
  )
 )

(setq doom-big-font (font-spec :family "Cartograph Mono CF Heavy" :size 26))
(setq doom-theme 'doom-Iosvkem)
(global-visual-line-mode)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(toggle-frame-fullscreen)

;; exit insert mode by pressing jj
(setq-default evil-escape-key-sequence "jj")
(setq-default evil-escape-delay 0.2)
;;; config.el ends here
