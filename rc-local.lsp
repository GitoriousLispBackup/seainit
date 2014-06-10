(format t "Running rc-local.lsp~%")

(defvar *modprobe-path* (which-program "modprobe"))

;;Load modules specific to my machine:
;;I booted with fedora normally, got a list of loaded modules, and added them all here:
(defvar *module-list* 
  (list "tun" "bnep" "bluetooth" "6lowpan_iphc" "fuse" "arc4"
	"ath9k" "ath9k_common" "uvcvideo" "ath9k_hw" "ath" "mac80211"
	"cfg80211" "snd_hda_codec_hdmi" "snd_hda_codec_realtek" "snd_hda_codec_generic"
	"snd_hda_intel" "snd_hda_codec" "snd_hwdep" "snd_seq" "videobuf2_vmalloc"
	"videobuf2_memops" "videobuf2_core" "videodev" "sony_laptop" "snd_seq_device"
	"r8169" "media" "snd_pcm" "rfkill" "mii" "kvm_amd" "kvm"
	"sp5100_tco" "snd_timer" "snd" "soundcore" "microcode" "joydev"
	"serio_raw" "k10temp" "edac_core" "edac_mce_amd" "i2c_piix4" "shpchp"
	"video" "acpi_cpufreq" "uinput"
	"binfmt_misc" "usb_storage"
	"ata_generic" "pata_acpi"
	"radeon" "i2c_algo_bit" "drm_kms_helper" "ttm" "pata_atiixp" "drm"
	"i2c_core"))

(dolist (module-i *module-list*)
  (format t "Attempting to insert kernel module ~a~%" module-i)
  (sb-ext:run-program *modprobe-path* (list module-i) :output t :error t))

;;Remount the root FS as RW:
(sb-ext:run-program (which-program "mount") (list "/" "-o" "remount,rw"))
