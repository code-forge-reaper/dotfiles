;; -------------------------
;; Language modes / Tools
;; -------------------------
(use-package go-mode
  :ensure t)
(use-package php-mode
  :ensure t)
(use-package lua-mode
  :ensure t)
(use-package nim-mode
  :ensure t)
(use-package typescript-mode
  :ensure t)
(use-package zig-mode
  :ensure t)

(if (file-directory-p (expand-file-name "modes/*.el" user-emacs-directory))
  (mapc #'load
    (directory-files
     "~/.config/emacs/modes"
     t
     "\\.el$"))
)
