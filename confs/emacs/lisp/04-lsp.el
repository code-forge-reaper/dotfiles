;; -------------------------
;; LSP (language server) and UI
;; -------------------------
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((c-mode csharp-mode c++-mode lua-mode python-mode typescript-mode) . lsp-deferred)
  :init
  (setq
   lsp-enable-on-type-formatting nil
  ;; lsp-enable-indentation nil
  ;; lsp-completion-provider :capf
  ;; lsp-prefer-flymake nil
  )
  :config
  (add-to-list 'lsp-language-id-configuration '(c++-mode . "cpp"))
  (add-to-list 'lsp-language-id-configuration '(c-mode . "c")))

(setq lsp-inlay-hint-enable t)
(setq lsp-enable-folders-blacklist nil)

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-enable-symbol-highlighting t))
