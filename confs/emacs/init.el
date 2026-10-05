(load (expand-file-name "config.el" user-emacs-directory))

(mapc #'load
      (file-expand-wildcards
       (expand-file-name "lisp/*.el" user-emacs-directory)))
