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
;;; funcs.el ends here
