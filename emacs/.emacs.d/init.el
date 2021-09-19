;; -*- lexical-binding: t -*-
(setq inhibit-startup-message t) ; disable startup message

(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1)  ; Disable the toolbar
(tooltip-mode -1) ; Disable tooltips
(set-fringe-mode 15) ; Some breathing room
(menu-bar-mode -1) ; Disable menu bar

(setq visible-bell nil)
(setq ring-bell-function 'ignore) ; no thank you

(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package general
  :config
  (general-create-definer oem/leader-key-def
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (oem/leader-key-def
    "SPC" '(mode-line-other-buffer :which-key "toggle between recent buffers")
    "x" '(counsel-M-x :which-key "M-x")
    "b" '(:ignore t :which-key "buffer")
    "bb" '(switch-to-buffer :which-key "switch buffer")
    "bp" '(previous-buffer :which-key "previous buffer")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package key-chord
  :init
  (setq key-chord-two-keys-delay 0.3)
  (key-chord-define evil-insert-state-map "fd" 'evil-normal-state)
  :config
  (key-chord-mode 1))

(use-package hydra)
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(oem/leader-key-def
  "t" '(:ignore t :which-key "text")
  "tt" '(load-theme :which-key "load theme")
  "ts" '(hydra-text-scale/body :which-key "text scale")
  "tf" '(:ignore t :which-key "fonts")
  "tfF" '(lambda () (interactive) (set-face-attribute 'default nil :family "PragmataPro Mono" :height 140 :weight 'bold))
  "tff" '(lambda () (interactive) (set-face-attribute 'default nil :family "Tamsyn" :height 100 :weight 'normal)))

(use-package swiper
  :ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich)

(oem/leader-key-def
  "f" '(:ignore t :which-key "file")
  "ff" '(find-file :which-key "find file")
  "fr" '(counsel-buffer-or-recentf :which-key "recent files")
  "fc" '(lambda () (interactive) (find-file (expand-file-name "~/.dotfiles/emacs/.emacs.d/emacs.org"))))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/src")
    (setq projectile-project-search-path '("~/src")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(oem/leader-key-def
  "p" '(:ignore t :which-key "projects")
  "pf" '(projectile-find-file :which-text "find file in project")
  "pp" '(projectile-switch-project :which-text "switch projects"))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package company
  :after lsp-mode
  :hook (progr-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package magit)

(oem/leader-key-def
  "g" '(:ignore t :which-key "version control")
  "gg" '(magit-status :which-key "status"))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-callable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package flycheck)

(defun oem/rustic-mode-hook ()
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

(use-package rustic
  :config
  (setq rustic-lsp-client 'lsp-mode
        rustic-lsp-server 'rust-analyzer
        rustic-analuzer-command '("/usr/local/bin/rust-analyzer"))
  (setq rustic-format-on-save t)
  (setq rust-format-on-save t)
  (add-hook 'rustic-mode-hook 'oem/rustic-mode-hook))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :custom
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-headerline-breadcrumb-enable nil)
  :hook (
         (rust-mode . lsp-deferred)
         (ruby-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)))

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-enable nil))

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)

(use-package evil-nerd-commenter)

(oem/leader-key-def
  "/" '(evilnc-comment-or-uncomment-lines :which-key "comment"))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 35))

(use-package doom-themes
  :init (load-theme 'doom-plain-dark t))

(use-package all-the-icons)

(pcase system-type
  ((or 'gnu/linux 'windows-nt 'cygwin)
   (set-face-attribute 'default nil :family "Tamsyn" :height 100 :weight 'normal))
  ('darwin
   (set-face-attribute 'default nil :font "PragmataPro Mono" :height 140 :weight 'bold)

   ;; for mac os: transparent titlebar without icons
   (add-to-list 'default-frame-alist  '(ns-transparent-titlebar . t))
   (setq ns-use-proxy-icon nil)
   (setq frame-title-format nil)))

(setq-default line-spacing 10)

(set-face-attribute 'fixed-pitch nil :family "Tamsyn" :weight 'normal)
(set-face-attribute 'variable-pitch nil :font "Avenir Next LT Pro" :weight 'regular)

(set-face-attribute 'org-block-begin-line nil :family "Tamsyn" :weight 'normal)
(set-face-attribute 'org-block-end-line nil :family "Tamsyn" :weight 'normal)
(set-face-attribute 'org-block nil :family "Tamsyn" :weight 'normal)

(toggle-frame-maximized)

(defun oem/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . oem/org-mode-setup)
  :config
  (setq org-ellipsis " ✜")

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-tag-alist
        '((:startgroup)
          ; put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("idea" . ?i)))

  (load-library "find-lisp")
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-window-setup 'current-window)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; org habit
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  ;; save org buffers after refiling
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;; custom org agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Tasks")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work")

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Backlog")))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready")))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active")))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed")))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled")))
            )))))

(oem/leader-key-def
  "o" '(:ignore t :which-key "org")
  "oa" '(org-agenda :which-key "org-agenda"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◎" "◉" "○" "●")))

(require 'org-indent)

(dolist (face '((org-level-1 . 2.8)
                (org-level-2 . 2.2)
                (org-level-3 . 1.8)
                (org-level-4 . 1.4)
                (org-level-5 . 1.2)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)
                (org-document-title . 1.3)))
  (set-face-attribute (car face) nil :font "Avenir Next LT Pro" :weight 'bold :height (cdr face)))

;; we don't want variable fonts for everything in org mode:
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
(set-face-attribute 'org-drawer nil :inherit 'fixed-pitch)
(set-face-attribute 'org-document-title nil :foreground nil :inherit 'variable-pitch)
(set-face-attribute 'org-document-info-keyword nil :weight 'bold :inherit 'fixed-pitch)
(set-face-attribute 'org-property-value nil :inherit 'fixed-pitch)
(set-face-attribute 'org-date nil :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

(defun oem/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . oem/org-mode-visual-fill))

(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   (python . t)))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(defun oem/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.dotfiles/emacs/.emacs.d/emacs.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook
          (lambda () (add-hook 'after-save-hook #'oem/org-babel-tangle-config)))

(use-package org-roam
  :demand t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/sync/notes")
  (org-roam-completion-everywhere t)
  :bind (
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))

(defun oem/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun oem/org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (oem/org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun oem/org-roam-refresh-agenda-list ()
  (interactive)
  (setq org-agenda-files (oem/org-roam-list-notes-by-tag "Project")))

(oem/org-roam-refresh-agenda-list)

(defun oem/org-roam-project-finalize-hook ()
    "Adds the captured project file to `org-agenda-files' if the
  capture was not aborted."
    ;; Remove the hook since it was added temporarily
    (remove-hook 'org-capture-after-finalize-hook #'oem/org-roam-project-finalize-hook)

    ;; Add project file to the agenda list if the capture was confirmed
    (unless org-note-abort
      (with-current-buffer (org-capture-get :buffer)
        (add-to-list 'org-agenda-files (buffer-file-name)))))

  (defun oem/org-roam-find-project ()
    (interactive)
    ;; Add the project file to the agenda after capture is finished
    (add-hook 'org-capture-after-finalize-hook #'oem/org-roam-project-finalize-hook)

    ;; Select a project file to open, creating it if necessary
    (org-roam-node-find
     nil
     nil
     (oem/org-roam-filter-by-tag "Project")
     :templates
     '(("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
        :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Project")
        :unnarrowed t))))

(global-set-key (kbd "C-c n p") #'oem/org-roam-find-project)

(defun oem/org-roam-capture-inbox()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("i" "inbox" plain "* %?\n %U\n %a\n %i"
                                   :if-new (file+head "inbox.org" "#+title: Inbox\n")))))

(defun oem/org-roam-capture-metrics()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("w" "Water" table-line "| %U | %^{Glasses} |"
                                   :if-new (file+head+olp "metrics.org"
                                                          "#+title: Personal metrics\n"
                                                          ("Water")))
                                  ("W" "Weight" table-line "| %U | %^{kg} | %^{notes} |"
                                   :if-new (file+head+olp "metrics.org"
                                                          "#+title: Personal metrics\n"
                                                          ("Weight"))))))

(defun oem/org-roam-capture-task()
  (interactive)
  ;; add the project file to the agenda after capture is finished
  (add-hook 'org-capture-after-finalize-hook #'oem/org-roam-project-finalize-hook)

  ;; capture the new task, creating the project file if necessary
  (org-roam-capture-
   :node (org-roam-node-read
          nil
          (oem/org-roam-filter-by-tag "Project"))
   :templates '(("p" "project" plain "** TODO %?"
                 :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
                                        "#+title: ${title}\n#+category: ${title}\n#+filetags: Project"
                                        ("Tasks"))))))

(defun oem/org-roam-copy-to-today (keep)
  (interactive)
  (let ((org-refile-keep keep) ;; Set this to nil to delete the original!
        (org-roam-dailies-capture-templates
         '(("t" "tasks" entry "%?"
            :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Tasks")))))
        (org-after-refile-insert-hook #'save-buffer)
        today-file
        pos)
    (save-window-excursion
      (org-roam-dailies--capture (current-time) t)
      (setq today-file (buffer-file-name))
      (setq pos (point)))

    ;; Only refile if the target file is different than the current file
    (unless (equal (file-truename today-file)
                   (file-truename (buffer-file-name)))
      (org-refile nil nil (list "Tasks" today-file nil pos)))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (if (and (equal org-state "DONE") (equal buffer-file-name "/home/oem/sync/notes/todos.org"))
                 (oem/org-roam-copy-to-today nil)
                 (if (equal org-state "DONE")
                 (oem/org-roam-copy-to-today t)))))

(defun oem/org-refile-to (file headline)
  "Move current headline to specific location"
  (interactive)
  (let ((org-after-refile-insert-hook #'save-buffer)
        (pos (save-window-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (when (and (equal org-state "TODO") (equal buffer-file-name "/home/oem/sync/notes/inbox.org"))
                 (oem/org-refile-to "~/sync/notes/todos.org" "Tasks"))))

(oem/leader-key-def
  "ob" '(org-roam-buffer-toggle :which-text "org roam buffer toggle")
  "od" '(:ignore t :which-key "org roam dailies")
  "odn" '(org-roam-dailies-goto-next-note :which-key "org roam dailies -> next")
  "odp" '(org-roam-dailies-goto-previous-note :which-key "org roam dailies -> previous")
  "odd" '(org-roam-dailies-goto-today :which-key "org roam dailies -> today")
  "ody" '(org-roam-dailies-capture-yesterday :which-key "org roam dailies yesterday")
  "odt" '(org-roam-dailies-capture-tomorrow :which-key "org roam dailies tomorrow")
  "oc" '(:ignore t :which-key "org roam capture")
  "oci" '(oem/org-roam-capture-inbox :which-key "org roam capture into inbox")
  "ocm" '(oem/org-roam-capture-metrics :which-key "org roam capture metrics")
  "ocp" '(oem/org-roam-capture-task :which-key "org roam capture into project")
  "op" '(oem/org-roam-find-project :which-key "find or create project")
  "oo" '(org-roam-node-find :which-key "org roam node find")
  "oi" '(org-roam-node-insert :which-key "org roam node insert"))

(use-package pinentry)

(require 'epg)
(setq epg-pinentry-mode 'loopback)

(pinentry-start)

(load "~/sync/mail-config/accounts.el")

(setq mu4e-attachment-dir "~/Downloads"
      mu4e-view-show-images t
      mu4e-use-fancy-chars t)
