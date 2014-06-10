(load "common-functions.lsp")

;;Step 1: Bring up the interfaces.

(defvar *ifconfig-path* (which-program "ifconfig"))
(defvar *iwconfig-path* (which-program "iwconfig"))
(defvar *dhclient-path* (which-program "dhclient"))
(defvar *route-path* (which-program "route"))

(load "network-interface-descriptors.lsp")

(defun manage-network-interface (interface-descriptor)
  "Brings up a network interface using the information in the interface descriptor."
  ;;Step 0: Status information
  (format t "Daemon started for interface ~A~%" (getf interface-descriptor :name))

  ;;Step 1: set the interface to 'up'.
  (sb-ext:run-program
   *ifconfig-path*
   (list (getf interface-descriptor :name)
	 "up"))
  ;;Step 2: If an essid is mentioned, it's probably a wireless
  ;;interface and we should configure it with iwconfig.
  (when (getf interface-descriptor :essid)
    (sb-ext:run-program
     *iwconfig-path*
     (list (getf interface-descriptor :name)
	   "essid"
	   (getf interface-descriptor :essid)))
    (sleep 1.0));;Sleep to allow the connection to be established.
  ;;ToDo: Replace the sleep with some kind of polling.
  ;;Step 3: Set the address
  (if (getf interface-descriptor :use-dhcp)
      (sb-ext:run-program
       *dhclient-path*
       (list (getf interface-descriptor :name)))
      (sb-ext:run-program
       *ifconfig-path*
       (list (getf interface-descriptor :name)
	     (getf interface-descriptor :address))))
  ;;Step 4: Set the routes, if any.
  (dolist (route-i (getf interface-descriptor :routes))
    (sb-ext:run-program
     *route-path*
     (list
	"add" 
	"-net"
	   (getf route-i :net)
	   "gw"
	   (getf route-i :gateway)
	   "dev"
	   (getf interface-descriptor :name))))

  ;;ToDo: Loop and maintain the status of the interface
  )

(defun manage (interface-name)
  (dolist (i (remove-if-not
	      (lambda (iface-i) (equal (getf iface-i :name) interface-name))
	      *network-interface-descriptors*))
    (manage-network-interface i)))
