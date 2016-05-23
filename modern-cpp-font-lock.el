;;; modern-cpp-font-lock.el --- Font-locking for "Modern C++"

;; Copyright © 2016, by Ludwig PACIFICI

;; Author: Ludwig PACIFICI <ludwig@lud.cc>
;; URL: https://github.com/ludwigpacifici/modern-cpp-font-lock
;; Version: 0.0.1
;; Created: 12 May 2016
;; Keywords: languages, c++, cpp, font-lock

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Syntax coloring support for "Modern C++" - until C++17 and TS
;; (Technical Specification). It is recommended to use it in addition
;; with the `c++-mode` major-mode.

;; * Melpa: [M-x] package-install [RET] modern-cpp-font-lock [RET]
;;   In your init Emacs file add:
;;       (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
;;   or:
;;       (modern-c++-font-lock-global-mode t)

;; For the current buffer, the minor-mode can be turned on/off via the command:
;;     [M-x] modern-c++-font-lock-mode [RET]

;; More documentation:
;; https://github.com/ludwigpacifici/modern-cpp-font-lock/blob/master/README.md

;; Feedback is welcome!

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
  "List of C++ types. See doc:
http://en.cppreference.com/w/cpp/language/types"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-literals
  '("false" "nullptr" "true")
  "List of C++ literals. See doc:
http://en.cppreference.com/w/cpp/language/bool_literal"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-preprocessors
  (sort '("#define" "#defined" "#elif" "#else" "#endif" "#error" "#if" "#ifdef" "#ifndef" "#include" "#line" "#pragma STDC CX_LIMITED_RANGE" "#pragma STDC FENV_ACCESS" "#pragma STDC FP_CONTRACT" "#pragma once" "#pragma pack" "#pragma" "#undef" "_Pragma" "__DATE__" "__FILE__" "__LINE__" "__STDCPP_STRICT_POINTER_SAFETY__" "__STDCPP_THREADS__" "__STDC_HOSTED__" "__STDC_ISO_10646__" "__STDC_MB_MIGHT_NEQ_WC__" "__STDC_VERSION__" "__STDC__" "__TIME__" "__VA_AR_GS__" "__cplusplus" "__has_include")
        'modern-c++-string-lenght>)
  "List of C++ preprocessor words. See doc:
http://en.cppreference.com/w/cpp/keyword and
http://en.cppreference.com/w/cpp/preprocessor"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-keywords
  (sort '("alignas" "alignof" "and" "and_eq" "asm" "atomic_cancel" "atomic_commit" "atomic_noexcept" "auto" "bitand" "bitor" "break" "case" "catch" "class" "compl" "concept" "const" "const_cast" "constexpr" "continue" "decltype" "default" "delete" "do" "dynamic_cast" "else" "enum" "explicit" "export" "extern" "final" "for" "friend" "goto" "if" "import" "inline" "module" "mutable" "namespace" "new" "noexcept" "not" "not_eq" "operator" "or" "or_eq" "override" "private" "protected" "public" "register" "reinterpret_cast" "requires" "return" "sizeof" "sizeof..." "static" "static_assert" "static_cast" "struct" "switch" "synchronized" "template" "this" "thread_local" "throw" "transaction_safe" "transaction_safe_dynamic" "try" "typedef" "typeid" "typename" "union" "using" "virtual" "volatile" "while" "xor" "xor_eq")
        'modern-c++-string-lenght>)
  "List of C++ keywords. See doc:
http://en.cppreference.com/w/cpp/keyword"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-attributes
  (sort '("carries_dependency" "deprecated" "fallthrough" "maybe_unused" "nodiscard" "noreturn" "optimize_for_synchronized")
        'modern-c++-string-lenght>)
  "List of C++ attributes. See doc:
http://en.cppreference.com/w/cpp/language/attributes"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(defcustom modern-c++-operators
  (sort '("...")
        'modern-c++-string-lenght>)
  "List of C++ assignment operators. Left Intentionally almost
empty. The user will choose what should be font-locked. By
default I want to avoid a 'christmas tree' C++ code. For more
information, see doc:
http://en.cppreference.com/w/cpp/language/operators"
  :type '(choice (const :tag "Disabled" nil)
                 '(repeat string))
  :group 'modern-c++-font-lock)

(setq modern-c++-font-lock-keywords
      (let ((types-regexp (regexp-opt modern-c++-types 'words))
            (preprocessors-regexp (regexp-opt modern-c++-preprocessors))
            (keywords-regexp (regexp-opt modern-c++-keywords 'words))
            (literal-regexp (regexp-opt modern-c++-literals 'words))
            (attributes-regexp
             (concat "\\[\\[\\(" (regexp-opt modern-c++-attributes 'words) "\\).*\\]\\]"))
            (operators-regexp (regexp-opt modern-c++-operators)))
        `(
          ;; Note: order below matters, because once colored, that part
          ;; won't change. In general, longer words first
          (,types-regexp . font-lock-type-face)
          (,preprocessors-regexp . font-lock-preprocessor-face)
          (,keywords-regexp . font-lock-keyword-face)
          (,literal-regexp . font-lock-constant-face)
          (,attributes-regexp 1 font-lock-constant-face)
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
