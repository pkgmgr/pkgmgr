;;; selectfile-mode.el --- Selectfile major mode

;; Copyright (C) 2021 Eddie Hillenbrand

;; Author: EddieHillenbrand
;; Keywords: extensions

;; This file is NOT part of GNU Emacs.
;; This program is actual free software; it uses the permisive MIT
;; license _not_ the GPL.


;;; Commentary:

;; pkgmgr Selectfile mode
;;
;; Install with use-package
;;
;;    (use-package selectfile-mode
;;     :load-path "$PMROOT/pkgmgr/tools/emacs")
;;


;;; Code:

;;;###autoload
(define-generic-mode selectfile-mode
  ;; comment
  (list ?#)

  ;; keywords
  (list "skip" "import" "desc" "longdesc" "homepage")

  ;; font-lock faces
  '(("freebsd" . 'font-lock-constant-face)
    ("macports" . 'font-lock-constant-face)
    ("pkgsrc" . 'font-lock-constant-face))

  ;; auto load
  (list "Selectfile")

  ;; additional functions
  nil

  ;; doc string
  "Major mode for pkgmgr Selectfile import control files.")

(provide 'selectfile-mode)
;;; selectfile-mode.el ends here
