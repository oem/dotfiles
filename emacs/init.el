;; -- lexical-bindiing: t; --
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
  "fd" '(:ignore t :which-key "find dotfiles")
  "fc" '(lambda () (interactive) (find-file (expand-file-name "~/src/oem/dotfiles/emacs/emacs.org"))))

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
    (setq-local  buffer-save-without-query t)))

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
  (setq org-agenda-files
        (find-lisp-find-files "~/sync/brain/tasks/" "\.org$"))
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-window-setup 'current-window)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  ;; org habit
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  ;; org refile targets
  (setq org-refile-targets
        '(("archive.org" :maxlevel . 3)
          ("tasks.org" :maxlevel . 2)))

  ;; save org buffers after refiling
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;; custom org agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))
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
            ))))

  (setq org-capture-templates
        `(("t" "Tasks / Projects")
          ("tt" "Task" entry (file+olp "~/sync/brain/tasks/tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
          ("m" "Metrics")
          ("mw" "Water" table-line (file+headline "~/sync/brain/tasks/metrics.org" "Water")
           "| %U | %^{Glasses} |" :kill-buffer t)
          ("mW" "Weight" table-line (file+headline "~/sync/brain/tasks/metrics.org" "Weight")
           "| %U | %^{kg} | %^{notes} |" :kill-buffer t))))

(oem/leader-key-def
  "o" '(:ignore t :which-key "org")
  "oa" '(org-agenda :which-text "org-agenda")
  "or" '(org-refile :which-text "org-refile")
  "oc" '(org-capture :which-text "org-capture"))

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
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Avenir Next LT Pro" :weight 'bold :height (cdr face)))

;; we don't want variable fonts for everything in org mode:
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil :inherit 'fixed-pitch)
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
                      (expand-file-name "~/src/oem/dotfiles/emacs/emacs.org"))
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
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
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

(defun oem/org-roam-capture-inbox()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("i" "inbox" plain "* %?"
                                   :if-new (file+head "inbox.org" "#+title: Inbox\n")))))

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

(oem/leader-key-def
  "oob" '(org-roam-buffer-toggle :which-text "org roam buffer toggle")
  "ooci" '(oem/org-roam-capture-inbox :which-text "org roam capture")
  "oocp" '(oem/org-roam-capture-task :which-text "org roam capture into project")
  "oop" '(oem/org-roam-find-project :which-text "find or create project")
  "ooo" '(org-roam-node-find :which-text "org roam node find")
  "ooi" '(org-roam-node-insert :which-text "org roam node insert"))

(use-package pinentry)

(setq epg-pinentry-mode 'loopback)

(pinentry-start)

(use-package mu4e
  ;; we want to keep mu4e and mu in sync, which is installed by our distro package manager
  :ensure nil
  :config
  ;; set to t to avoid mail syncing issues when uusing mbsync
  (setq mu4e-change-filenames-when-moving t)
  ;; refresh mail using isync every 10 minutes
  ;; (setq mu4e-update-interval (* 10 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/sync/mail")

  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "darkoem-gmail"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/darkoem-gmail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "darkoem@gmail.com")
                  (user-full-name . "Ömür Özkir")

                  (mu4e-drafts-folder . "/darkoem-gmail/drafts")
                  (mu4e-sent-folder . "/darkoem-gmail/sent")
                  (mu4e-refile-folder . "/darkoem-gmail/all")
                  (mu4e-trash-folder . "/darkoem-gmail/trash")
                  (mu4e-compose-signature . "")))

         (make-mu4e-context
          :name "oemuer-oezkir-gmail"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/oemuer-oezkir-gmail" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "oemuer.oezkir@gmail.com")
                  (user-full-name . "Ömür Özkir")

                  (mu4e-drafts-folder . "/oemuer-oezkir-gmail/drafts")
                  (mu4e-sent-folder . "/oemuer-oezkir-gmail/sent")
                  (mu4e-refile-folder . "/oemuer-oezkir-gmail/all")
                  (mu4e-trash-folder . "/oemuer-oezkir-gmail/trash")
                  (mu4e-compose-signature . "")))


         (make-mu4e-context
          :name "njiuko"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/oemuer-oezkir-njiuko" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "oemuer.oezkir@njiuko.com")
                  (user-full-name . "Ömür Özkir")

                  (mu4e-drafts-folder . "/oemuer-oezkir-njiuko/drafts")
                  (mu4e-sent-folder . "/oemuer-oezkir-njiuko/sent")
                  (mu4e-refile-folder . "/oemuer-oezkir-njiuko/all")
                  (mu4e-trash-folder . "/oemuer-oezkir-njiuko/trash")
                  (mu4e-compose-signature . "")))))

  (setq mu4e-maildir-shortcuts
        '(("/darkoem-gmail/Inbox" . ?i)
          ("/darkoem-gmail/sent" . ?s)
          ("/darkoem-gmail/bin" . ?b)
          ("/darkoem-gmail/drafts" . ?d)
          ("/darkoem-gmail/all" . ?a))))

(oem/leader-key-def
  "m" '(:ignore t :which-key "mail")
  "mm" '(mu4e :which-key "mu4e")
  "ms" '(mu4e-headers-search :which-key "mail search"))
