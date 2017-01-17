;;; packages.el --- rtags layer packages file for Spacemacs.
;;
;; Copyright (c) 2017 Eric Nordström
;;
;; Author: Eric Nordström <eric@nrdstrm.org>
;;
;; This file is not part of GNU Emacs.

(defconst rtags-packages
  '(cmake-ide
    rtags))

(defun rtags/init-cmake-ide ()
  (use-package cmake-ide
    :config
    (cmake-ide-setup)))

(defun rtags/init-rtags ()
  (use-package rtags
    :config
    (setq rtags-autostart-diagnostics t
          rtags-completions-enabled t
          rtags-use-helm t)
    ; See https://github.com/Andersbakken/rtags/issues/832
    (require 'rtags-helm)
    (push '(company-rtags)
          company-backends-c-mode-common)
    (rtags-enable-standard-keybindings)
    (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running))
  (use-package flycheck-rtags
    :ensure rtags))

;;; packages.el ends here
