;;; modern-cpp-font-lock.el --- font-locking for C++ mode

;; Copyright © 2016, by Ludwig PACIFICI

;; Author: Ludwig PACIFICI <ludwig@lud.cc>
;; URL: https://github.com/ludwigpacifici/modern-cpp-font-lock
;; Version: 0.0.1
;; Created: 12 May 2016
;; Keywords: languages, c++, cpp, font-lock

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Provides font-locking for C++ mode

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(setq modern-cpp-keywords '("if" "override"))

(setq modern-cpp-keywords-regexp (regexp-opt modern-cpp-keywords 'words))

(setq modern-cpp-font-lock-keywords
      `(
        (,modern-cpp-keywords-regexp . font-lock-keyword-face)
        ))

;;;###autoload
(define-minor-mode modern-cpp-font-lock-mode
  "Provides font-locking as a Minor Mode for Modern C++"

  (font-lock-add-keywords nil modern-cpp-font-lock-keywords)

  ;(setq font-lock-defaults '((modern-cpp-font-lock-keywords)))

  (if (fboundp 'font-lock-flush)
      (font-lock-flush)
    (when font-lock-mode
      (with-no-warnings (font-lock-fontify-buffer)))))

(setq modern-cpp-keywords nil)
(setq modern-cpp-keywords-regexp)

(provide 'modern-cpp-font-lock)

;; Local Variables:
;; coding: utf-8
;; End:

;;; modern-cpp-font-lock.el ends here
