;;; modern-cpp-font-lock.el --- font-locking for C++ mode

;; Copyright © 2016, by Ludwig PACIFICI

;; Author: Ludwig PACIFICI <ludwig@lud.cc>
;; URL: https://github.com/ludwigpacifici/modern-cpp-font-lock
;; Version: 0.0.1
;; Created: 12 May 2016
;; Keywords: languages, c++, cpp, font-lock

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Syntax coloring support for "Modern C++" - until C++17 and TS (Technical Specification). It is recommended to use it in addition with the `c++-mode` major-mode.

;; Download `modern-cpp-font-lock.el` into a directory of your load-path. Place the following lines in a suitable init file:

;;    (require 'modern-cpp-font-lock)
;;    (modern-c++-font-lock-global-mode t)

;; `modern-c++-font-lock-mode` will be activated for buffers using the `c++-mode` major-mode.

;; For the current buffer, the minor-mode can be turned on/off via the command:

;; <kbd>M-x modern-c++-font-lock-mode [RET]</kbd>

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

(defgroup modern-c++-font-lock nil
  "Provides font-locking as a Minor Mode for Modern C++"
  :group 'faces)

(defun modern-c++-string-lenght< (a b) (< (length a) (length b)))
(defun modern-c++-string-lenght> (a b) (not (modern-c++-string-lenght< a b)))

(defcustom modern-c++-types
  '("bool" "char" "char16_t" "char32_t" "double" "float" "int" "long" "short" "signed" "unsigned" "void" "wchar_t")
  "List of C++ types. See doc: http://en.cppreference.com/w/cpp/language/types"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-hash-preprocessors
  (sort '("define" "defined" "elif" "else" "endif" "error" "if" "ifdef" "ifndef" "include" "line" "pragma STDC CX_LIMITED_RANGE" "pragma STDC FENV_ACCESS" "pragma STDC FP_CONTRACT" "pragma once" "pragma pack" "pragma" "undef")
        'modern-c++-string-lenght>)
  "List of C++ preprocessor words starting with '#'. See doc: http://en.cppreference.com/w/cpp/keyword and http://en.cppreference.com/w/cpp/preprocessor"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-_preprocessors
  "Pragma"
  "List of C++ preprocessor words starting with '_'. See doc: http://en.cppreference.com/w/cpp/keyword and http://en.cppreference.com/w/cpp/preprocessor"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-__preprocessors__
  (sort '("DATE" "FILE" "LINE" "STDCPP_STRICT_POINTER_SAFETY" "STDCPP_THREADS" "STDC_HOSTED" "STDC_ISO_10646" "STDC_MB_MIGHT_NEQ_WC" "STDC_VERSION" "STDC" "TIME" "VA_AR_GS")
        'modern-c++-string-lenght>)
  "List of C++ preprocessor words surounded with '__'. See doc: http://en.cppreference.com/w/cpp/keyword and http://en.cppreference.com/w/cpp/preprocessor"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-__preprocessors
  (sort '("cplusplus" "has_include")
        'modern-c++-string-lenght>)
  "List of C++ preprocessor words starting with '__'. See doc: http://en.cppreference.com/w/cpp/keyword and http://en.cppreference.com/w/cpp/preprocessor"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-keywords
  (sort '("alignas" "alignof" "and" "and_eq" "asm" "atomic_cancel" "atomic_commit" "atomic_noexcept" "auto" "bitand" "bitor" "bool" "break" "case" "catch" "char" "char16_t" "char32_t" "class" "compl" "concept" "const" "const_cast" "constexpr" "continue" "decltype" "default" "delete" "do" "double" "dynamic_cast" "else" "enum" "explicit" "export" "extern" "false" "final" "float" "for" "friend" "goto" "if" "import" "inline" "int" "long" "module" "mutable" "namespace" "new" "noexcept" "not" "not_eq" "nullptr" "operator" "or" "or_eq" "override" "private" "protected" "public" "register" "reinterpret_cast" "requires" "return" "short" "signed" "sizeof" "sizeof..." "static" "static_assert" "static_cast" "struct" "switch" "synchronized" "template" "this" "thread_local" "throw" "transaction_safe" "transaction_safe_dynamic" "true" "try" "typedef" "typeid" "typename" "union" "unsigned" "using" "virtual" "void" "volatile" "wchar_t" "while" "xor" "xor_eq")
        'modern-c++-string-lenght>)
  "List of C++ keywords. See doc: http://en.cppreference.com/w/cpp/keyword"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-attributes
  (sort '("carries_dependency" "deprecated" "fallthrough" "maybe_unused" "nodiscard" "noreturn" "optimize_for_synchronized")
        'modern-c++-string-lenght>)
  "List of C++ attributes. See doc: http://en.cppreference.com/w/cpp/language/attributes"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-attribute-reasons
  "deprecated"
  "List of C++ attributes containing a reason. See doc: http://en.cppreference.com/w/cpp/language/attributes"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-assignment
  '("%=" "&=" "*=" "+=" "-=" "/=" "<<=" "=" ">>=" "^=" "|=")
  "List of C++ assignment operators. See doc: http://en.cppreference.com/w/cpp/language/operator_assignment"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-increment-decrement
  '("++" "--")
  "List of C++ increment/decrement operators. See doc: http://en.cppreference.com/w/cpp/language/operator_incdec"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-arithmetic
  '("+" "-" "+" "-" "*" "/" "%" "~" "&" "|" "^" "<<" ">>")
  "List of C++ arithmetic operators. See doc: http://en.cppreference.com/w/cpp/language/operator_arithmetic"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-logical
  '("!" "&&" "||")
  "List of C++ logical operators. See doc: http://en.cppreference.com/w/cpp/language/operator_logical"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-comparison
  '("==" "!=" "<" ">" "<=" ">=")
  "List of C++ comparison operators. See doc: http://en.cppreference.com/w/cpp/language/operator_comparison"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-member-access
  '("*" "&" "->" "." "->*" ".*")
  "List of C++ member access operators. See doc: http://en.cppreference.com/w/cpp/language/operator_member_access"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-other
  '("..." "," "?" ":")
  "List of C++ other operators. See doc: http://en.cppreference.com/w/cpp/language/operator_other"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators-all
  (sort (append modern-c++-operators-assignment modern-c++-operators-increment-decrement modern-c++-operators-arithmetic modern-c++-operators-logical modern-c++-operators-comparison modern-c++-operators-member-access modern-c++-operators-other)
        'modern-c++-string-lenght>)
  "List of C++ operators. See doc: http://en.cppreference.com/w/cpp/language/operator_precedence"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(setq modern-c++-font-lock-keywords
      (let ((types-regexp (regexp-opt modern-c++-types 'words))
            (preprocessors-regexp
             (concat "#" (regexp-opt modern-c++-hash-preprocessors 'words)
                     "\\|_" modern-c++-_preprocessors
                     "\\|__" (regexp-opt modern-c++-__preprocessors 'words)
                     "\\|__" (regexp-opt modern-c++-__preprocessors__ 'words) "__"))
            (keywords-regexp (regexp-opt modern-c++-keywords 'words))
            (attributes-regexp
             (concat "\\[\\[" (regexp-opt modern-c++-attributes 'words) "\\]\\]"
                     "\\|\\[\\[" modern-c++-attribute-reasons "\\(.*\\)\\]\\]"))
            (operators-regexp
             (concat "\\(" (mapconcat 'regexp-quote modern-c++-operators-all "\\|") "\\)")))
        `(
          ;; Note: order below matters, because once colored, that part
          ;; won't change. In general, longer words first
          (,types-regexp . font-lock-type-face)
          (,preprocessors-regexp . font-lock-preprocessor-face)
          (,keywords-regexp . font-lock-keyword-face)
          (,attributes-regexp . font-lock-constant-face)
          (,operators-regexp . font-lock-function-name-face)
          )))

(defun modern-c++-font-lock-add-keywords (&optional mode)
  "Install keywords into major MODE, or into current buffer if nil."
  (font-lock-add-keywords mode modern-c++-font-lock-keywords nil))

(defun modern-c++-font-lock-remove-keywords (&optional mode)
  "Remove keywords from major MODE, or from current buffer if nil."
  (font-lock-remove-keywords mode modern-c++-font-lock-keywords))

;;;###autoload
(define-minor-mode modern-c++-font-lock-mode
  "Provides font-locking as a Minor Mode for Modern C++"
  :init-value nil
  :lighter " mc++fl"
  :group 'modern-c++-font-lock
  (if modern-c++-font-lock-mode
      (modern-c++-font-lock-add-keywords)
    (modern-c++-font-lock-remove-keywords))
  ;; As of Emacs 24.4, `font-lock-fontify-buffer' is not legal to
  ;; call, instead `font-lock-flush' should be used.
  (if (fboundp 'font-lock-flush)
      (font-lock-flush)
    (when font-lock-mode
      (with-no-warnings
        (font-lock-fontify-buffer)))))

;;;###autoload
(defcustom modern-c++-font-lock-modes '(c++-mode)
  "List of major modes where Modern C++ Font Lock Global mode should be enabled."
  :group 'modern-c++-font-lock
  :type '(repeat symbol))

;;;###autoload
(define-global-minor-mode modern-c++-font-lock-global-mode modern-c++-font-lock-mode
  (lambda ()
    (when (apply 'derived-mode-p modern-c++-font-lock-modes)
      (modern-c++-font-lock-mode 1)))
  :group 'modern-c++-font-lock)

(provide 'modern-cpp-font-lock)

;; coding: utf-8

;;; modern-cpp-font-lock.el ends here
