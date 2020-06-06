;; (when (configuration-layer/package-used-p 'dap-mode)
;;   (defun gmmoreira--dap-ruby-populate-start-file-args (conf)
;;     "Populate CONF with the required arguments."
;;     (-> conf
;;       (dap--put-if-absent :dap-server-path dap-ruby-debug-program)
;;       (dap--put-if-absent :type "Ruby")
;;       (dap--put-if-absent :cwd (projectile-project-root))
;;       (dap--put-if-absent :request "launch")
;;       (dap--put-if-absent :program "bin/bundle")
;;       (dap--put-if-absent :args `("exec" ,rspec-spec-command ,(rspec-spec-file-for (buffer-file-name)))))))

(when (and
        (configuration-layer/package-used-p 'dap-mode)
        (configuration-layer/package-used-p 'rspec-mode)
        (configuration-layer/package-used-p 'projectile))
  (defun gmmoreira--dap-ruby-populate-start-file-args (conf)
    "Populate CONF with the required arguments."
        (-> conf
          (dap--put-if-absent :dap-server-path dap-ruby-debug-program)
          (dap--put-if-absent :type "Ruby")
          (dap--put-if-absent :cwd (projectile-project-root))
          (dap--put-if-absent :request "launch")
          (dap--put-if-absent :program "bin/bundle")
          (when (eq (plist-get conf :name) "Ruby RSpec File")
            (plist-put conf :name `("exec" ,rspec-spec-command ,(rspec-spec-file-for (buffer-file-name))))))))
;; (when (and
;;         (configuration-layer/package-used-p 'dap-mode)
;;         (configuration-layer/package-used-p 'rspec-mode)
;;         (configuration-layer/package-used-p 'projectile))
;;   (defun gmmoreira--dap-ruby-populate-start-file-args (conf)
;;     "Populate CONF with the required arguments."
;;     (-> conf
;;       (dap--put-if-absent :dap-server-path dap-ruby-debug-program)
;;       (dap--put-if-absent :type "Ruby")
;;       (dap--put-if-absent :cwd (projectile-project-root))
;;       (dap--put-if-absent :request "launch")
;;       (dap--put-if-absent :program "bin/bundle")
;;       (when (eq (plist-get conf :name) "Ruby RSpec File")
;;         (dap--put-if-absent :args `("exec" ,rspec-spec-command ,(rspec-spec-file-for (buffer-file-name))))
;;         )
;;       )
;;     )
;;   )
                                        ; file-executable-p

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
