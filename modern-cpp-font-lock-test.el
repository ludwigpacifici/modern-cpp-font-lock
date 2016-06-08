(require 'faceup)

(defvar modern-cpp-font-lock-test-dir (faceup-this-file-directory))

(defun modern-cpp-font-lock-test-facit (dir)
  "Test that `dir'/test.cc is fontifies as the .faceup file describes.
`dir' is interpreted as relative to this source directory."
  (faceup-test-font-lock-file 'c++-mode
                              (concat
                               modern-cpp-font-lock-test-dir
                               dir
                               "/test.cc")))

(faceup-defexplainer modern-cpp-font-lock-test-facit)

(ert-deftest modern-cpp-font-lock-file-test ()
  (should (modern-cpp-font-lock-test-facit "cpp/preview"))
  (should (modern-cpp-font-lock-test-facit "cpp/integer-literal")))

(provide 'modern-cpp-font-lock-test)
