;; This is the seainit bootstrap server, the first component of
;; seainit which is written in lisp.

;; This server simply establishes a smiple api and then evaluates the
;; configuration file to start all daemons and system services.

(format t "seainit bootstrap server started.~%")

(load "common-functions.lsp")

(load "rc-local.lsp")

;;Run this first, as there may be network filesystems to mount.
(lisp-run "network-daemon.lsp")

;;Run this second, as later things may depend on the filesystems.
(load "fs-mount.lsp")

(lisp-run "tty-daemons.lsp")

(loop
   (sleep 1.0))
