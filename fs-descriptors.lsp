;;This file is the equivalent of the /etc/fstab file.
(defvar *fs-descriptors*
  (list
   (list :name "/dev/sda1" :mount-point "/mnt/1" :mode :rw)
   (list :name "/dev/sda2" :mount-point :swap :mode :rw)
   (list :name "/dev/sda3" :mount-point "/mnt/2" :mode :rw)
   (list :bind-p t :name "/mnt/2/home" :mount-point "/home/" :mode :rw)))
