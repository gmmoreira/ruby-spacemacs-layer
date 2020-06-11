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
  '(dap-mode rubocop))

(defun gmmoreira-ruby/pre-init-dap-mode ()
  (spacemacs|use-package-add-hook dap-mode
    :post-config
    (dap-register-debug-template
      "Ruby RSpec File"
      (list :type "Ruby"
        :name "Ruby RSpec File"))
    (dap-register-debug-template
      "Ruby RSpec File Single"
      (list :type "Ruby"
        :name "Ruby RSpec File Single")))
  ;; I had to look in ruby layer to figure out how to register my adapter after the dap-ruby is required, otherwise my adapter was being overridden
  (spacemacs/add-to-hooks #'gmmoreira--dap-ruby-setup
    '(ruby-mode-local-vars-hook
       enh-ruby-mode-local-vars-hook)))

(defun gmmoreira-ruby/post-init-rubocop ()
  (dolist (mode '(ruby-mode enh-ruby-mode))
    (spacemacs/declare-prefix-for-mode mode "mR" "RuboCop")
    (spacemacs/set-leader-keys-for-major-mode mode
      "RF" 'rubocop-autocorrect-current-file)))
;;; packages.el ends here
