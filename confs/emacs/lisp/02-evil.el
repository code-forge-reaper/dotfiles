;; -------------------------
;; Editing / Modal bindings
;; -------------------------
;; Must set before evil loads
(setq evil-want-keybinding nil)
(prefer-coding-system 'utf-8)

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "f") #'lsp-format-buffer))

(use-package evil-collection
  :ensure t
  :after evil
  :init
  (evil-collection-init)
  (evil-set-initial-state 'dired-mode 'normal)
)

;; Electric pairs
(electric-pair-mode 1)
