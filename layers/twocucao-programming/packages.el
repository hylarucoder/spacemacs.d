
(setq twocucao-programming-packages
      '(
        js2-mode
        js2-refactor
        json-mode
        jade-mode
        web-mode
        css-mode
        (python :location built-in)
        (vue-mode :location (recipe :fetcher github :repo "sallen450/vue-mode"))
        ))

(defun twocucao-programming/init-python()
  (setq python-shell-extra-pythonpaths '("/Users/twocucao/Codes/DQChina/DQChinaWeb/dqchinaweb"))
  (add-to-list 'python-shell-extra-pythonpaths "/Users/twocucao/Codes/Repos/YaDjangoWeb")
  (add-to-list 'python-shell-extra-pythonpaths "/Users/twocucao/Codes/Repos/YaDjangoApp")
  (add-to-list 'python-shell-extra-pythonpaths "/Users/twocucao/Codes/Repos/YaPyLib")
  )
(defun twocucao-programming/post-init-python()
  (add-hook 'python-mode-hook (lambda ()
                                (flycheck-mode 1)
                                (semantic-mode 1)
                                (setq flycheck-checker 'python-pylint
                                      flycheck-checker-error-threshold 900
                                      flycheck-pylintrc "~/.pylintrc"))))

(defun twocucao-progeamming/post-init-mmm-mode ()
  (use-package mmm-mode))

(defun twocucao-programming/post-init-jade-mode ()
  (use-package jade-mode))

(defun twocucao-programming/post-init-web-mode ()
  (use-package web-mode)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  )

(defun twocucao-programming/post-init-css-mode ()
  (progn
    (dolist (hook '(css-mode-hook sass-mode-hook less-mode-hook))
      (add-hook hook 'rainbow-mode))

    (defun css-imenu-make-index ()
      (save-excursion
        (imenu--generic-function '((nil "^ *\\([^ ]+\\) *{ *$" 1)))))

    (add-hook 'css-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'css-imenu-make-index)))))

(defun twocucao-programming/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (global-eslint (executable-find "eslint"))
         (local-eslint (expand-file-name "node_modules/.bin/eslint"
                                         root))
         (eslint (if (file-executable-p local-eslint)
                     local-eslint
                   global-eslint)))
    (setq-local flycheck-javascript-eslint-executable eslint)))
