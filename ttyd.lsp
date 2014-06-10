(load "common-functions.lsp")

(load "tty-descriptors.lsp")

(defun manage-tty (tty-descriptor)
  ;;ToDo: When this program dies, restart it.
  (sb-ext:run-program
   (which-program "setsid")
   (list
    "agetty"
    (getf tty-descriptor :name))
   :input nil
   :output nil))

(defun manage (tty-name)
  (format t "Daemon for ~A started.~%" tty-name)
  (dolist (tty-i
	    (remove-if-not 
	     (lambda (tty-i)
	       (equal (getf tty-i :name) tty-name))
	     *tty-descriptors*))
    (manage-tty tty-i)))
