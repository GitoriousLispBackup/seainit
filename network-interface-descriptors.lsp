;;Store your network interface information as a list here.

;;Format:

;;(list descriptor-0 descriptor-1 ... descriptor-n)

;;Valid descriptor indicators include:
;;
;; :name STRING, the interface name, such as eth0, wlan0, etc.

;; :use-dhcp Z, either Nil or T, whether to run dhclient on the interface or not.

;; :essid STRING, the essid to connect to if this is a wireless interface

;; :routes (list route-0 route-1 ... route-n)
;;   
;;   Individual routes have format: 
;;
;;   (list :net A :gateway B), where A is a string that is either
;;   'default' or a network address in 'x.y.z.w/n' form, and B is the
;;   address of the gateway.

(defvar *network-interface-descriptors*
  (list

   (list :name "p4p1" :use-dhcp t)

   (list :name "wlan0" :use-dhcp nil :essid "sea" :address
	 "192.168.100.3" 
	 :routes (list 
		  (list 
		   :net "default";;Alternatively, specify x.y.z.w/n 
		   :gateway "192.168.100.2")))))
