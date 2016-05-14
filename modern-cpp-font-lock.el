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

(defgroup modern-cpp-font-lock nil
  "Provides font-locking as a Minor Mode for Modern C++"
  :group 'faces)

;; http://en.cppreference.com/w/cpp/keyword
(setq modern-cpp-keywords '("alignas" "alignof" "and" "and_eq" "asm" "atomic_cancel" "atomic_commit" "atomic_noexcept" "auto" "bitand" "bitor" "bool" "break" "case" "catch" "char" "char16_t" "char32_t" "class" "compl" "concept" "const" "const_cast" "constexpr" "continue" "decltype" "default" "delete" "do" "double" "dynamic_cast" "else" "enum" "explicit" "export" "extern" "false" "final" "float" "for" "friend" "goto" "if" "import" "inline" "int" "long" "module" "mutable" "namespace" "new" "noexcept" "not" "not_eq" "nullptr" "operator" "or" "or_eq" "override" "private" "protected" "public" "register" "reinterpret_cast" "requires" "return" "short" "signed" "sizeof" "static" "static_assert" "static_cast" "struct" "switch" "synchronized" "template" "this" "thread_local" "throw" "transaction_safe" "transaction_safe_dynamic" "true" "try" "typedef" "typeid" "typename" "union" "unsigned" "using" "virtual" "void" "volatile" "wchar_t" "while" "xor" "xor_eq"))

;; http://en.cppreference.com/w/cpp/keyword
(setq modern-cpp-preprocessors '("_Pragma" "#define" "#defined" "#elif" "#else" "#endif" "#error" "#if" "#ifdef" "#ifndef" "#include" "#line" "#pragma" "#undef"))

(setq modern-cpp-keywords-regexp (regexp-opt modern-cpp-keywords 'words))
(setq modern-cpp-preprocessors-regexp (mapconcat 'regexp-quote modern-cpp-preprocessors "\\|"))


(setq modern-cpp-font-lock-keywords
      `(
        ;; Note: order above matters, because once colored, that part
        ;; won't change. In general, longer words first
        (,modern-cpp-preprocessors-regexp . font-lock-preprocessor-face)
        (,modern-cpp-keywords-regexp . font-lock-keyword-face)
        ))

(defun modern-cpp-font-lock-add-keywords (&optional mode)
  "Install keywords into major MODE, or into current buffer if nil."
  (font-lock-add-keywords mode modern-cpp-font-lock-keywords nil))

(defun modern-cpp-font-lock-remove-keywords (&optional mode)
  "Remove keywords from major MODE, or from current buffer if nil."
  (font-lock-remove-keywords mode modern-cpp-font-lock-keywords))

;;;###autoload
(define-minor-mode modern-cpp-font-lock-mode
  "Provides font-locking as a Minor Mode for Modern C++"
  :group 'modern-cpp-font-lock
  (if modern-cpp-font-lock-mode
      (modern-cpp-font-lock-add-keywords)
    (modern-cpp-font-lock-remove-keywords))
  ;; As of Emacs 24.4, `font-lock-fontify-buffer' is not legal to
  ;; call, instead `font-lock-flush' should be used.
  (if (fboundp 'font-lock-flush)
      (font-lock-flush)
    (when font-lock-mode
      (with-no-warnings
        (font-lock-fontify-buffer)))))

;;;###autoload
(defcustom modern-cpp-font-lock-modes '(c++-mode)
  "List of major modes where Modern C++ Font Lock Global mode should be enabled."
  :group 'modern-cpp-font-lock
  :type '(repeat symbol))

;;;###autoload
(define-global-minor-mode modern-cpp-font-lock-global-mode modern-cpp-font-lock-mode
  (lambda ()
    (when (apply 'derived-mode-p modern-cpp-font-lock-modes)
      (modern-cpp-font-lock-mode 1)))
  :group 'modern-cpp-font-lock)

;; Clear memory. no longer needed

(setq modern-cpp-keywords nil)
(setq modern-cpp-types nil)

(setq modern-cpp-keywords-regexp nil)
(setq modern-cpp-types-regexp nil)

(provide 'modern-cpp-font-lock)

;; coding: utf-8

;;; modern-cpp-font-lock.el ends here
