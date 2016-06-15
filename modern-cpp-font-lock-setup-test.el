;;; modern-cpp-font-lock-test-setup.el --- Setup and execute all tests

;;; Commentary:

;; This package sets up a suitable enviroment for testing
;; modern-cpp-font-lock, and executes the tests.
;;
;; Usage:
;;
;;   emacs -q -l modern-cpp-font-lock-test-setup.el
;;
;; Note that this package assumes that some packages are located in
;; specific locations.

;;; Code:

(prefer-coding-system 'utf-8)

(defvar modern-cpp-font-lock-test-setup-directory
  (if load-file-name
      (file-name-directory load-file-name)
    default-directory))

(dolist (dir '("." "./faceup"))
  (add-to-list 'load-path
               (concat modern-cpp-font-lock-test-setup-directory dir)))

(require 'modern-cpp-font-lock)
(add-hook 'text-mode-hook #'modern-c++-font-lock-mode)

(require 'modern-cpp-font-lock-test)

(ert t)

;;; modern-cpp-font-lock-test-setup.el ends here
