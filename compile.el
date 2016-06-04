(setq files '("faceup/faceup.el"
              "modern-cpp-font-lock.el"))
(setq byte-compile--use-old-handlers nil)
(mapc #'byte-compile-file files)
