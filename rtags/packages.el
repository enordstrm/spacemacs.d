;;; packages.el --- rtags layer packages file for Spacemacs.
;;; Code:

(defconst rtags-packages
  '(rtags))

(defun rtags/init-rtags ()
  (use-package rtags
    :ensure company
    :config
    (setq rtags-autostart-diagnostics t
          rtags-completions-enabled t
          rtags-use-helm t
          ;;rtags-verbose-results t ;; Actually slows less, bug?
          rtags-rdm-process-use-pipe nil
          rtags-diagnostics-use-pipe nil
          rtags-tramp-enabled t)
    ; See https://github.com/Andersbakken/rtags/issues/832
    (require 'company-rtags)
    (require 'rtags-helm)
    (push '(company-rtags)
          company-backends-c-mode-common)
    (rtags-enable-standard-keybindings)
    (rtags-diagnostics)

    ; Disable this function in order to resolve tramp issue
    (defun rtags-update-current-project ())

    ; Useful if running locally, but start is manually due to remote-edit
    ;;(add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
    )
  (use-package flycheck-rtags
    :ensure rtags))

;;; packages.el ends here
