;;seainit tty daemons.

(format t "TTY daemons starting.~%")

(load "common-functions.lsp")

(load "tty-descriptors.lsp")

(dolist (tty-i *tty-descriptors*)
  (format t "Starting a daemon for a tty on VT ~a~%" (getf tty-i :name))
  (sb-ext:run-program
   *sbcl-path*
   (list
    "--noinform"
    "--non-interactive"
    "--no-userinit"
    "--eval" (format nil "(progn (load \"ttyd.lsp\")(manage ~S))" 
		     (getf tty-i :name)))
   :output t))
