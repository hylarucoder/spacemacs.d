
(setq twocucao-programming-packages
      '(
        flycheck
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

(defun twocucao-programming/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (progn
      (setq flycheck-display-errors-delay 0.9)
      (setq flycheck-idle-change-delay 2.0))
    (dolist (checker '(javascript-eslint javascript-standard))
      (flycheck-add-mode checker 'vue-mode)
      (flycheck-add-mode checker 'js2-mode)
      (flycheck-add-mode checker 'web-mode)
      ))
  (add-hook 'vue-mode-hook #'twocucao-programming/use-eslint-from-node-modules)
  (add-hook 'web-mode-hook 'my-web-mode-indent-setup)
  (add-hook 'vue-mode-hook 'my-web-mode-indent-setup)
  (spacemacs/add-flycheck-hook 'vue-mode)
  (spacemacs/add-flycheck-hook 'js2-mode)
  (spacemacs/add-flycheck-hook 'web-mode)
  )
