;; -------------------------
;; Terminal / File browsing
;; -------------------------
(use-package vterm
  :ensure t)

(use-package consult
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "b") #'consult-buffer)
  (add-to-list 'consult-buffer-filter "^\\*")
  )
(define-key evil-normal-state-map (kbd "-") #'dired-jump)
(evil-collection-define-key 'normal 'dired-mode-map
	"t" #'dired-create-empty-file)
