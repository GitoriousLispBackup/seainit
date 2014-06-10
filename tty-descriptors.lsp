;;These are the TTY descriptors.

(defvar *tty-descriptors*
  (loop for i from 2 to 9 collect
       (list 
	:name (format nil "tty~A" i))))
