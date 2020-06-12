(defun gmmoreira--dap-ruby-populate-start-file-args (conf)
  "Populate CONF with the required arguments."
  (let* ((args))
    (when (string-equal (plist-get conf :name) "Ruby RSpec File")
      (setq
        args (list "exec" rspec-spec-command (rspec-spec-file-for (buffer-file-name)))))
    (when (string-equal (plist-get conf :name) "Ruby RSpec File Single")
      (setq
        args (list "exec" rspec-spec-command (format "%s:%s" (rspec-spec-file-for (buffer-file-name)) (line-number-at-pos)))))
    (when (string-equal (plist-get conf :name) "Rails Server")
      (setq
        args (list "exec" "rails" "server")))
    (-> conf
      (dap--put-if-absent :dap-server-path dap-ruby-debug-program)
      (dap--put-if-absent :type "Ruby")
      (dap--put-if-absent :cwd (projectile-project-root))
      (dap--put-if-absent :request "launch")
      (dap--put-if-absent :program (gmmoreira-bundle-command-path))
      (dap--put-if-absent :args args)
      )
    )
  )

(defun gmmoreira-bundle-command-path ()
  (if (file-executable-p (expand-file-name "bin/bundle" (projectile-project-root)))
    "bin/bundle"
    "bundle"))

(defun gmmoreira--dap-ruby-setup ()
  (dap-register-debug-provider "Ruby" 'gmmoreira--dap-ruby-populate-start-file-args)
  )

;; The following section is here just for reference

;; file-executable-p

;; (defun dap-java--populate-launch-args (conf)
;;   "Populate CONF with launch related configurations."
;;   (when (not (and (plist-get conf :mainClass)
;;                   (plist-get conf :projectName)))
;;     (-let [(&hash "mainClass" main-class "projectName" project-name) (dap-java--select-main-class)]
;;       (setq conf (plist-put conf :mainClass main-class))
;;       (plist-put conf :projectName project-name)))

;;   (-let [(&plist :mainClass main-class :projectName project-name) conf]
;;     (-> conf
;;         (dap--put-if-absent :args "")
;;         (dap--put-if-absent :cwd (lsp-java--get-root))
;;         (dap--put-if-absent :stopOnEntry :json-false)
;;         (dap--put-if-absent :host "localhost")
;;         (dap--put-if-absent :console "internalConsole")
;;         (dap--put-if-absent :request "launch")
;;         (dap--put-if-absent :modulePaths (vector))
;;         (dap--put-if-absent :classPaths
;;                             (or (cl-second
;;                                  (with-lsp-workspace (lsp-find-workspace 'jdtls)
;;                                    (lsp-send-execute-command
;;                                     "vscode.java.resolveClasspath"
;;                                     (vector main-class project-name))))
;;                                 (error "Unable to resolve classpath")))
;;         (dap--put-if-absent :name (format "%s (%s)"
;;                                           (if (string-match ".*\\.\\([[:alnum:]_]*\\)$" main-class)
;;                                               (match-string 1 main-class)
;;                                             main-class)
;;                                           project-name)))))
;;; funcs.el ends here
