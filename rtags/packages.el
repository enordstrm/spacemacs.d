;;; packages.el --- rtags layer packages file for Spacemacs.
;;; Code:

(defconst rtags-packages
  '(company-rtags
    helm-rtags
    flycheck-rtags
    rtags))

(defun rtags/init-flycheck-rtags ()
  (use-package flycheck-rtags
    :ensure t))

(defun rtags/init-company-rtags ()
  (use-package company-rtags
    :ensure t
    :config
    (push '(company-rtags)
          company-backends-c-mode-common)
    ))

(defun rtags/init-helm-rtags ()
  (use-package helm-rtags
               :ensure t))

(defun rtags/init-rtags ()
  (use-package rtags
    :ensure t
    :config
    (setq rtags-autostart-diagnostics t
          rtags-completions-enabled t
          rtags-display-result-backend 'helm
          rtags-use-helm t
          ;;rtags-verbose-results t ;; Actually slows less, bug?
          ;;rtags-rdm-process-use-pipe nil
          ;;rtags-diagnostics-use-pipe nil
          rtags-tramp-enabled t)
    ; See https://github.com/Andersbakken/rtags/issues/832
    (rtags-enable-standard-keybindings)
    (rtags-diagnostics)

    ; Disable this function in order to resolve tramp issue
    (defun rtags-update-current-project ())

    ; Useful if running locally, but start is manually due to remote-edit
    ;;(add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
    ))

;;; packages.el ends here
