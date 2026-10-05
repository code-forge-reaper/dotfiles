;; Auto-revert buffers
(global-auto-revert-mode 1)

;; Scrolling precision
;;(pixel-scroll-precision-mode 1)
;; Line numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; Font and tab settings
(setq-default tab-width 4)
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-16")
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-16"))

;; Disable backup/lock/autosave
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; Handy aliases
(defalias 'lf 'lsp-format-buffer)
