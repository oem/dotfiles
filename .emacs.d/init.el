;; sensible defaults
(setq delete-old-versions -1 ) ; delete excess backup versions silently
(setq version-control t )      ; use version control
(setq vc-make-backup-files t ) ; make backup file even when in version control dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t )) ) ; transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq initial-scratch-message "system online") ; print a default message in the empty scratch buffer opened at startup
(tool-bar-mode -1) ; do not show the toolbar when launched as GUI

;; packages
(require 'package)
(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up for new packages.
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(require 'use-package)

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package which-key :ensure t)  ; nice short explanations for keybinds
(use-package counsel :ensure t)
(use-package swiper :ensure t)
(use-package key-chord :ensure t)
(use-package general
  :ensure t
  :config
  (general-define-key
   "C-'" 'acy-goto-word-1
   ;; replace default keybindings
   "C-s" 'swiper ; search for string in current buffer
   "M-x" 'counsel-M-x ; replace default M-x with ivy

   :prefix "C-c"
   ;; bind to simple key press
   "b"	'ivy-switch-buffer  ; change buffer, chose using ivy
   "/"   'counsel-git-grep   ; find string in git project
   ;; bind to double key press
   "f"   '(:ignore t :which-key "files")
   "ff"  'counsel-find-file
   "fr"	'counsel-recentf
   "p"   '(:ignore t :which-key "project")
   "pf"  '(counsel-git :which-key "find file in git dir")))

(use-package avy :ensure t
	     :commands (avy-goto-word-1))

;; looks
(add-hook 'after-init-hook (lambda () (load-theme 'spacemacs-dark t)))
(setq default-frame-alist '((font . "Cartograph Mono CF Extra Bold-16")))
(scroll-bar-mode -1)
(set-face-background 'font-lock-comment-face "#c0c0c0")
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq-default line-spacing 16)
(global-linum-mode 1)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(general-define-key
 :keymaps '(normal insert emacs)
 :non-normal-prefix "M"
 "/" 'swiper)

;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-safe-themes
   (quote
    ("8d805143f2c71cfad5207155234089729bb742a1cb67b7f60357fdd952044315" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "73c69e346ec1cb3d1508c2447f6518a6e582851792a8c0e57a22d6b9948071b4" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (spacegray-theme doom-themes key-chord anti-zenburn-theme ## spacemacs-theme counsel swiper swipe evil which-key use-package general avy)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(spacemacs-theme-comment-bg nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
