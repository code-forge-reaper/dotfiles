;; -------------------------
;; UI / Appearance
;; -------------------------
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1))
