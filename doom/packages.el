;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)
; (package! lsp-python-ms
;   :ensure nil
;   :hook (python-mode . lsp-python-enable)
;   :config
;
;   ;; for dev build of language server
;   (setq lsp-python-ms-dir
;         (expand-file-name "~/src/python-language-server/output/bin/Release/"))
