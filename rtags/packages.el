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
          rtags-verbose-results t
          rtags-rdm-process-use-pipe nil
          rtags-diagnostics-use-pipe nil
          rtags-rc-log-enabled t)
    ; See https://github.com/Andersbakken/rtags/issues/832
    (require 'company-rtags)
    (require 'rtags-helm)
    (push '(company-rtags)
          company-backends-c-mode-common)
    (rtags-enable-standard-keybindings)
    (rtags-diagnostics)
    (rtags-start-process-unless-running)
    (rtags-diagnostics)
    ;(add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
    )
  (use-package flycheck-rtags
    :ensure rtags))

;;; packages.el ends here
