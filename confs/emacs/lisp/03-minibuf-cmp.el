;; -------------------------
;; Minibuffer / Completion
;; -------------------------
(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Company for code completion
(use-package company
  :ensure t
  :hook (prog-mode . company-mode))


(add-hook 'ibuffer-mode-hook #'ibuffer-auto-mode)
;(global-set-key (kbd "C-x C-b") 'consult-buffer)
;(add-hook 'evil-local-mode-hook 'turn-on-undo-tree-mode)
(setq evil-undo-system 'undo-redo)
