;;Mounts the filesystems defined in fs-descriptors.lsp

(format t "Mounting filesystems.~%")

(load "fs-descriptors.lsp")

(defun mount (name mount-point bind-p mode)
  (if (equal :swap mount-point)
      (sb-ext:run-program (which-program "swapon") (list name))
    (sb-ext:run-program
     (which-program "mount")
     (append (if bind-p (list "--bind") nil)
	     (list 
	      ;;RW,RO,etc:
	      (getf (list :rw "--read-write" :ro "--read-only") mode)
	      ;;name and mount-point
	      name
	      mount-point)) :error t :output t)))

(dolist (fs-i *fs-descriptors*)
  (mount (getf fs-i :name)
	 (getf fs-i :mount-point)
	 (getf fs-i :bind-p)
	 (getf fs-i :mode)))
