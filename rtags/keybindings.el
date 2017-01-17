;;; packages.el --- rtags layer packages file for Spacemacs.
;;
;; Copyright (c) 2017 Eric Nordström
;;
;; Author: Eric Nordström <eric@nrdstrm.org>
;;
;; This file is not part of GNU Emacs.
;;; keybindings.el

(defconst rtags-overrides
  '(("C-]" 'rtags-find-symbol-at-point)
    ("M-." 'rtags-find-symbol-at-point)))

(defun rtags-set-evil-keys ()
  (dolist (override rtags-overrides)
    (evil-local-set-key 'normal (car override) (cdr override))))

(add-hook 'c-mode-common-hook 'rtags-set-evil-keys)

;;; https://github.com/mheathr/spacemacs/blob/develop/contrib/!lang/c-c%2B%2B/packages.el

(dolist (mode '(c-mode c++-mode))
  (evil-leader/set-key-for-mode mode
    "g ." 'rtags-find-symbol-at-point
    "g ," 'rtags-find-references-at-point
    "g v" 'rtags-find-virtuals-at-point
    "g V" 'rtags-print-enum-value-at-point
    "g /" 'rtags-find-all-references-at-point
    "g Y" 'rtags-cycle-overlays-on-screen
    "g >" 'rtags-find-symbol
    "g <" 'rtags-find-references
    "g [" 'rtags-location-stack-back
    "g ]" 'rtags-location-stack-forward
    "g D" 'rtags-diagnostics
    "g G" 'rtags-guess-function-at-point
    "g p" 'rtags-set-current-project
    "g P" 'rtags-print-dependencies
    "g e" 'rtags-reparse-file
    "g E" 'rtags-preprocess-file
    "g R" 'rtags-rename-symbol
    "g M" 'rtags-symbol-info
    "g S" 'rtags-display-summary
    "g O" 'rtags-goto-offset
    "g ;" 'rtags-find-file
    "g F" 'rtags-fixit
    "g L" 'rtags-copy-and-print-current-location
    "g X" 'rtags-fix-fixit-at-point
    "g B" 'rtags-show-rtags-buffer
    "g I" 'rtags-imenu
    "g T" 'rtags-taglist
    "g h" 'rtags-print-class-hierarchy
    "g a" 'rtags-print-source-arguments))

(provide 'keybindings)
;;; keybindings.el ends here
