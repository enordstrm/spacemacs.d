;;; packages.el --- remote-edit layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Eric Nordstrom <enoeric@elx398m242-ag>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `remote-edit-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `remote-edit/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `remote-edit/pre-init-PACKAGE' and/or
;;   `remote-edit/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:


(defconst remote-edit-packages
  '(tramp))

(defun remote-edit/init-tramp()
  ;;(quelpa '(tramp
  ;;          :fetcher git
  ;;          :url "git://git.savannah.gnu.org/tramp.git"
  ;;          :files ("lisp/*.el" "texi/*.texi")))
  (use-package tramp
    :ensure t
    :init
    (autoload 'tramp-check-proper-method-and-host "tramp.el")
    :config
    (setq
     ;; Auto save storage.
     tramp-auto-save-directory (path-join *user-auto-save-directory* "tramp")
     ;; Default file transfer method.
     tramp-default-method "ssh"
     ;; Cache passwords.
     password-cache t
     password-cache-expiry 1000
     ;; SSH is properly configured to share connections.
     tramp-use-ssh-controlmaster-options nil
     ;; Skip looking for dir-local on remote system to speed up tramp.
     enable-remote-dir-locals nil
     ;; Preserve PATH on remote host.
     tramp-remote-path (delete 'tramp-default-remote-path tramp-remote-path))

    ;; Preserve PATH on remote host.
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

    (tramp-set-completion-function
     "ssh" (mapcar
            (lambda (x) (list 'tramp-parse-sconfig x))
            (-remove
             (lambda (x) (not (file-exists-p x)))
             `(,(path-join "/" "etc" "ssh_config")
               ,(path-join "/" "etc" "ssh" "ssh_config")
               ,(path-join *user-home-directory* ".ssh" "config"))))))

  (use-package tramp-cache
    :config
    (setq
     ;; Persistency files.
     tramp-persistency-file-name (path-join *user-cache-directory* "tramp"))))

(defun path-join (root &rest dirs)
  "Join paths together starting at ROOT and proceeding with DIRS.
Ex: (path-join \"/tmp\" \"a\" \"b\" \"c\") => /tmp/a/b/c"
  (if (not dirs)
      root
    (apply 'path-join
           (expand-file-name (car dirs) root)
           (cdr dirs))))

;;; packages.el ends here
