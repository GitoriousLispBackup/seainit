;;seainit network daemons.

(format t "Network daemons starting.~%")

(load "common-functions.lsp")

(load "network-interface-descriptors.lsp")

(dolist (interface-i *network-interface-descriptors*)
  (format t "starting a daemon for network interface ~a~%" (getf interface-i :name))
  (sb-ext:run-program 
   *sbcl-path*
   (list 
    "--noinform"
    "--non-interactive"
    "--no-userinit"
    "--eval" (format nil "(progn (load \"network-interface.lsp\")(manage ~S))" 
	    (getf interface-i :name)))
   :wait t
   :error t
   :output t))
