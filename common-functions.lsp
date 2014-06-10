;;Determine the path of the WHICH program.
(defvar *which-path* "")

(dolist (i (list "/bin/which" "/usr/bin/which" "/sbin/which" "/usr/sbin/which"))
  (if (probe-file i)
      (setf *which-path* i)))

(defun which-program (program-name)
  "Uses /bin/which to get the program path of PROGRAM-NAME as a string, returns it."
  (read-line 
   (process-output 
    (sb-ext:run-program *which-path* (list program-name) :output :stream))))

(defvar *sbcl-path* (which-program "sbcl"))

(defun lisp-run (program-name)
  (sb-ext:run-program *sbcl-path* 
		      (list "--noinform"
			    "--non-interactive" 
			    "--no-userinit"
			    "--load" program-name)
		      :output t))
