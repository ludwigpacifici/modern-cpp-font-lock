(require 'faceup)

(defconst project-directory (faceup-this-file-directory)
  "Directory where the project lives")

(defconst test-directory "cpp"
  "Directory name where facit tests are")

(defconst cpp-filename "test.txt"
  "C++ filename that will be tested for font lock")

(defun facit-test-paths (root directory file)
  (mapcar (lambda (d) (concat root directory "/" d "/" file))
          (directory-files directory nil "^[^\\.].*")))

(defun facit-tests (root directory file)
  (mapcar (lambda (path) (should (faceup-test-font-lock-file 'text-mode path)))
          (facit-test-paths root directory file)))

(faceup-defexplainer facit-tests)

(ert-deftest modern-cpp-font-lock-file-test ()
  (facit-tests project-directory test-directory cpp-filename))

(provide 'modern-cpp-font-lock-test)
