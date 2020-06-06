;;; packages.el --- gmmoreira-ruby layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Guilherme Moreira <guilhermemoreira@IDC0221>
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
;; added to `gmmoreira-ruby-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `gmmoreira-ruby/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `gmmoreira-ruby/pre-init-PACKAGE' and/or
;;   `gmmoreira-ruby/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst gmmoreira-ruby-packages
  '(dap-mode)
  "The list of Lisp packages required by the gmmoreira-ruby layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun gmmoreira-ruby/post-init-dap-mode ()
  (require 'dap-mode) ; this should not be here
  (dap-register-debug-template
    "Ruby RSpec File"
    (list :type "Ruby"
      :name "Ruby RSpec File"))
  (dap-register-debug-provider "Ruby" 'gmmoreira--dap-ruby-populate-start-file-args)
  )
;;; packages.el ends here
