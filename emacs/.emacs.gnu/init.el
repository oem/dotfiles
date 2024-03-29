;; -*- lexical-binding: t -*-
(setq inhibit-startup-message t) ; disable startup message

(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1)  ; Disable the toolbar
(tooltip-mode -1) ; Disable tooltips
(set-fringe-mode 15) ; Some breathing room
(menu-bar-mode -1) ; Disable menu bar

(setq visible-bell nil)
(setq ring-bell-function 'ignore) ; no thank you

(setq comp-async-report-warnings-errors nil) ; silence native comp errors

(setq select-enable-clipboard t)
(setq select-enable-primary t)

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
    "x" '(execute-extended-command :which-key "execute extended command")
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

(use-package doom-themes
  :init (load-theme 'doom-plain-dark t))

(use-package rg
  :after wgrep
  :config
  (setq rg-group-result t)
  (setq rg-hide-command t)
  (setq rg-show-columns nil)
  (setq rg-show-header t)
  (setq rg-custom-type-aliases nil)
  (setq rg-default-alias-fallback "all")

  (rg-enable-default-bindings)

  (rg-define-search oem/grep-vc-or-dir
    :query ask
    :format regexp
    :files "everything"
    :dir (let ((vc (vc-root-dir)))
           (if vc
               vc
             default-directory))
    :confirm prefix
    :flags ("--hidden -g !.git")))

(oem/leader-key-def
  "s" '(:ignore t :which-key "search")
  "sr" '(oem/grep-vc-or-dir :which-key "in project")
  "sl" '(rg-list-searches :which-key "list searches"))

(oem/leader-key-def
  "f" '(:ignore t :which-key "file")
  "ff" '(find-file :which-key "find file")
  ;; "fr" '(counsel-buffer-or-recentf :which-key "recent files")
  "fc" '(lambda () (interactive) (find-file (expand-file-name "~/.dotfiles/emacs/.emacs.gnu/emacs.org"))))

(use-package vertico
  :bind (:map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-anotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package consult
  :demand t
  :bind (("C-s" . consult-line)
         :map minibuffer-local-map
         ("C-r" . consult-history)))

(oem/leader-key-def
  "ss" '(consult-ripgrep :which-key "ripgrep")
  "nn" '(lambda () (interactive) (consult-ripgrep "~/sync/notes") :which-key "search in notes"))

(use-package orderless
:init
(setq completion-styles '(orderless)
      completion-category-defaults nil
      completion-category-overrides '((file (styles . (partial-completion))))))

(use-package racket-mode)

(use-package evil-nerd-commenter)

(oem/leader-key-def
  "/" '(evilnc-comment-or-uncomment-lines :which-key "comment"))

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

(use-package expand-region
  :bind
  ("C-=" . er/expand-region)
  ("C--" . er/contract-region))

(use-package magit)

(oem/leader-key-def
  "v" '(:ignore t :which-key "version control")
  "vv" '(magit-status :which-key "status"))

(use-package helpful
  :bind
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(use-package flycheck
  :init
  (global-flycheck-mode t))

(defun oem/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . oem/org-mode-setup)
  :config
  (setq org-ellipsis " ✜")

  (setq org-todo-keywords
        '((sequence "TODO(t)" "MAYBE(m)" "NEXT(n)" "|" "DONE(d!)")
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

  (setq org-startup-folded 'nofold)

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
  "og" '(consult-org-heading :which-key "goto org file")
  "oa" '(org-agenda :which-key "org-agenda")
  "on" '(org-toggle-narrow-to-subtree :which-key "toggle narrowing"))

(use-package org-superstar
  :after org
  :custom
  (org-superstar-headline-bullets-list '("○" "⭙" "●" "●" "●" "○")))
(setq org-hide-leading-stars t)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(require 'org-indent)

(defun oem/org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . oem/org-mode-visual-fill))

(defun oem/org-todo-if-needed (state)
  "Change header state to STATE unless the current item is in STATE already"
  (unless (string-equal (org-get-todo-state) state)
    (org-todo state)))

(defun oem/org-summary-todo-cookie (n-done n-not-done)
  "Switch headet state to DONE when all subentries are DONE, to TODO when none are DONE, and to NEXT otherwise"
  (let (org-log-done org-log-states) ; turn off logging
    (oem/org-todo-if-needed (cond ((= n-done 0)
                                   "TODO")
                                  ((= n-not-done 0)
                                   "DONE")
                                  (t "NEXT")))))

(add-hook 'org-after-todo-statistics-hook #'oem/org-summary-todo-cookie)

(defun oem/org-summary-checkbox-cookie ()
  "Switch header state to DONE when all checkboxes are ticked, to TODO when not are ticked, and to NEXT otherwise"
  (let (beg end)
    (unless (not (org-get-todo-state))
      (save-excursion
        (org-back-to-heading t)
        (setq beg (point))
        (end-of-line)
        (setq end (point))
        (goto-char beg)
        ;; Regex group 1: %-based cookie
        ;; Regex group 2 and 3: x/y cookie
        (if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
                               end t)
            (if (match-end 1)
                ;; [xx%] cookie support
                (cond ((equal (match-string 1) "100%")
                       (oem/org-todo-if-needed "DONE"))
                      ((equal (match-string 1) "0%")
                       (oem/org-todo-if-needed "TODO")) 
                      (t
                       (oem/org-todo-if-needed "NEXT")))
              ;; [x/y] cookie support
              (if (> (match-end 2) (match-beginning 2)) ; = if not empty
                  (cond ((equal (match-string 2) (match-string 3))
                         (oem/org-todo-if-needed "DONE"))
                        ((or (equal (string-trim (match-string 2)) "")
                             (equal (match-string 2) "0"))
                         (oem/org-todo-if-needed "TODO"))
                        (t
                         (oem/org-todo-if-needed "NEXT")))
                (oem/org-todo-if-needed "NEXT"))))))))

(add-hook 'org-checkbox-statistics-hook #'oem/org-summary-checkbox-cookie)

(setq org-file-apps
    (quote
      ((auto-mode . emacs)
       ("\\.mm\\'" . default)
       ("\\.x?html?\\'" . "/usr/bin/firefox-developer-edition %s")
       ("\\.pdf\\'" . default))))

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
(add-to-list 'org-structure-template-alist '("rs" . "src rust"))

(defun oem/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.dotfiles/emacs/.emacs.gnu/emacs.org"))
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

(defun oem/org-refile-to (file headline)
  "Move current headline to specific location"
  (interactive)
  (let ((org-after-refile-insert-hook #'save-buffer)
        (pos (save-window-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos))))

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
               (unless (or (equal buffer-file-name "/home/oem/sync/notes/habits.org") (string-match "training" buffer-file-name))
                 (if (and (equal org-state "DONE") (equal buffer-file-name "/home/oem/sync/notes/todos.org"))
                     (oem/org-roam-copy-to-today nil)
                   (if (equal org-state "DONE")
                       (oem/org-roam-copy-to-today t))))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (when (and (equal org-state "TODO") (or (equal buffer-file-name "/home/oem/sync/notes/inbox.org") (equal buffer-file-name "/home/oem/sync/notes/maybe.org")))
                 (oem/org-refile-to "~/sync/notes/todos.org" ""))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (when (equal org-state "MAYBE")
                 (oem/org-refile-to "~/sync/notes/maybe.org" ""))))

(setq org-refile-targets
      '((nil :maxlevel . 3)
        (org-agenda-files :maxlevel . 3)))

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

(column-number-mode)
(setq display-line-numbers-type 'relative)

(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

(dolist (mode '(org-mode-hook
                org-agenda-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defun oem/set-faces (fixed-font variable-font)
  "Setting general fonts and org mode specific fonts"
  (set-face-attribute 'default nil :family fixed-font :weight 'bold :height 90)
  (set-face-attribute 'fixed-pitch nil :family fixed-font :weight 'bold :height 90)
  (set-face-attribute 'variable-pitch nil :family variable-font :weight 'regular :height 110)

  ;; org mode faces
  (dolist (face '((org-level-1 . 2.8)
                  (org-level-2 . 2.2)
                  (org-level-3 . 1.8)
                  (org-level-4 . 1.4)
                  (org-level-5 . 1.2)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)
                  (org-document-title . 1.3)))
    (set-face-attribute (car face) nil :family variable-font :weight 'bold :height (cdr face)))

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

  (set-face-attribute 'org-block-begin-line nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block-end-line nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch))

(pcase system-type
  ((or 'gnu/linux 'windows-nt 'cygwin)
   (oem/set-faces "Cartograph CF" "Avenir Next LT Pro"))
  ('darwin
   (oem/set-faces "Cartograph CF" "Avenir Next LT Pro")

   ;; for mac os: transparent titlebar without icons
   (add-to-list 'default-frame-alist  '(ns-transparent-titlebar . t))
   (setq ns-use-proxy-icon nil)
   (setq frame-title-format nil)))

(setq-default line-spacing 8)
(use-package all-the-icons)
(toggle-frame-maximized)

(oem/leader-key-def
  "t" '(:ignore t :which-key "text")
  "tt" '(load-theme :which-key "load theme")
  "tf" '(:ignore t :which-key "fonts")
  "tfF" '(lambda () (interactive)
           (oem/set-faces "Cartograph CF" "Avenir Next LT Pro"))
  "tff" '(lambda () (interactive)
           (oem/set-faces "Tamsyn" "Avenir Next LT Pro")))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 35))

(use-package highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'bitmap)

(use-package popper
  :bind (("C-`" . popper-toggle-latest)
         ("M-`" . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (popper-mode +1)
  (setq popper-reference-buffers
        '(Custom-mode
          compilation-mode
          messages-mode
          help-mode
          occur-mode
          "^\\*Warning\\*"
          "^\\*Compile-Log\\*"
          "^\\*Messages\\*"
          "^\\*Backtrace\\*"
          "^\\*evil-registers\\*"
          "^\\*Apropos"
          "^Calc:"
          "^\\*Shell Command Output\\*"
          "^\\*Async Shell Command\\*"
          "^\\*Completions\\*"
          "^\\*scratch\\*"
          "^\\*rustic-compilation\\*"
          "eshell\\*"
          "^\\*EMMS Playlist\\*"
          "[Oo]utput\\*")))

(setq popper-group-function #'popper-group-by-project)

(oem/leader-key-def
  "ee" '(popper-toggle-latest :which-key "latest popup")
  "eE" '(popper-toggle-type :which-key "make popup")
  "ec" '(popper-cycle :which-key "cycle popup"))

(oem/leader-key-def
  "ps" '(proced :which-key "processes"))

(use-package pinentry)

(require 'epg)
(setq epg-pinentry-mode 'loopback)

(pinentry-start)

(use-package pass
  :pin melpa
  :config
  (setf epg-pinentry-mode 'loopback))

(load "~/sync/mail-config/accounts.el")

(setq mu4e-attachment-dir "~/Downloads"
      mu4e-view-show-images t
      mu4e-use-fancy-chars t)

(setq mu4e-view-show-images t
      mu4e-show-images t
      mu4e-view-image-max-width 800)

(setq message-send-mail-function 'smtpmail-send-it)
(setq mu4e-sent-messages-behavior 'delete)

(require 'smtpmail)

(auth-source-pass-enable)
(setq auth-source-debug t)
(setq auth-source-do-cache nil)
(setq message-kill-buffer-on-exit t)
(setq smtpmail-debug-info t)
(setq smtpmail-stream-type 'ssl)

(use-package emms)
(require 'emms-setup)
(emms-all)
(emms-default-players)
(setq emms-source-file-default-directory "~/sync/music")

(use-package elfeed
  :config
  (setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
        elfeed-show-entry-switch 'display-buffer))

(use-package elfeed-org
  :config
  (setq elfeed-show-entry-switch 'display-buffer)
  (setq rmh-elfeed-org-files (list "~/sync/notes/feeds.org")))

(oem/leader-key-def
  "mf" '(elfeed :which-key "elfeed"))
