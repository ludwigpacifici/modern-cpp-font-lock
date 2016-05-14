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

(defgroup modern-c++-font-lock nil
  "Provides font-locking as a Minor Mode for Modern C++"
  :group 'faces)

(defun string-length< (a b) (< (length a) (length b)))
(defun string-length> (a b) (not (string-length< a b)))

;; http://en.cppreference.com/w/cpp/language/types
(setq modern-c++-types (sort '("bool" "char" "char16_t" "char32_t" "double" "float" "int" "long" "short" "signed" "unsigned" "void" "wchar_t") 'string-length>))

;; http://en.cppreference.com/w/cpp/keyword
;; http://en.cppreference.com/w/cpp/preprocessor
;; Preprocessor starting with '#'
(setq modern-c++-hash-preprocessors (sort '("define" "defined" "elif" "else" "endif" "error" "if" "ifdef" "ifndef" "include" "line" "pragma STDC CX_LIMITED_RANGE" "pragma STDC FENV_ACCESS" "pragma STDC FP_CONTRACT" "pragma once" "pragma pack" "pragma" "undef") 'string-length>))

;; Preprocessor starting with '_'
(setq modern-c++-_preprocessors "Pragma")

;; Preprocessor surounded with '__'
(setq modern-c++-__preprocessors__ (sort '("DATE" "FILE" "LINE" "STDCPP_STRICT_POINTER_SAFETY" "STDCPP_THREADS" "STDC_HOSTED" "STDC_ISO_10646" "STDC_MB_MIGHT_NEQ_WC" "STDC_VERSION" "STDC" "TIME" "VA_AR_GS") 'string-length>))

;; Preprocessor starting with '__'
(setq modern-c++-__preprocessors (sort '("cplusplus" "has_include") 'string-length>))

;; http://en.cppreference.com/w/cpp/keyword
(setq modern-c++-keywords (sort '("alignas" "alignof" "and" "and_eq" "asm" "atomic_cancel" "atomic_commit" "atomic_noexcept" "auto" "bitand" "bitor" "bool" "break" "case" "catch" "char" "char16_t" "char32_t" "class" "compl" "concept" "const" "const_cast" "constexpr" "continue" "decltype" "default" "delete" "do" "double" "dynamic_cast" "else" "enum" "explicit" "export" "extern" "false" "final" "float" "for" "friend" "goto" "if" "import" "inline" "int" "long" "module" "mutable" "namespace" "new" "noexcept" "not" "not_eq" "nullptr" "operator" "or" "or_eq" "override" "private" "protected" "public" "register" "reinterpret_cast" "requires" "return" "short" "signed" "sizeof" "static" "static_assert" "static_cast" "struct" "switch" "synchronized" "template" "this" "thread_local" "throw" "transaction_safe" "transaction_safe_dynamic" "true" "try" "typedef" "typeid" "typename" "union" "unsigned" "using" "virtual" "void" "volatile" "wchar_t" "while" "xor" "xor_eq") 'string-length>))

;; http://en.cppreference.com/w/cpp/language/attributes
(setq modern-c++-attributes (sort '("carries_dependency" "deprecated" "fallthrough" "maybe_unused" "nodiscard" "noreturn" "optimize_for_synchronized") 'string-length>))

;; Standard attributes with a reason
(setq modern-c++-attribute-reasons "deprecated")

(setq modern-c++-types-regexp (regexp-opt modern-c++-types 'words))

(setq modern-c++-preprocessors-regexp
      (concat "#" (regexp-opt modern-c++-hash-preprocessors 'words)
              "\\|_" modern-c++-_preprocessors
              "\\|__" (regexp-opt modern-c++-__preprocessors 'words)
              "\\|__" (regexp-opt modern-c++-__preprocessors__ 'words) "__"))

(setq modern-c++-keywords-regexp (regexp-opt modern-c++-keywords 'words))

(setq modern-c++-attributes-regexp
      (concat "\\[\\[" (regexp-opt modern-c++-attributes 'words) "\\]\\]"
              "\\|\\[\\[" modern-c++-attribute-reasons "\\(.*\\)\\]\\]"))

(setq modern-c++-font-lock-keywords
      `(
        ;; Note: order above matters, because once colored, that part
        ;; won't change. In general, longer words first
        (,modern-c++-types-regexp . font-lock-type-face)
        (,modern-c++-preprocessors-regexp . font-lock-preprocessor-face)
        (,modern-c++-keywords-regexp . font-lock-keyword-face)
        (,modern-c++-attributes-regexp . font-lock-constant-face)
        ))

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

;; Clear memory. no longer needed
(setq modern-c++-keywords-regexp nil)
(setq modern-c++-preprocessors-regexp nil)
(setq modern-c++-types-regexp nil)
(setq modern-c++-attributes-regexp nil)
(setq modern-c++-attribute-reasons nil)
(setq modern-c++-attributes nil)
(setq modern-c++-keywords nil)
(setq modern-c++-__preprocessors nil)
(setq modern-c++-__preprocessors__ nil)
(setq modern-c++-_preprocessors nil)
(setq modern-c++-hash-preprocessors nil)
(setq modern-c++-types nil)

(provide 'modern-cpp-font-lock)

;; coding: utf-8

;;; modern-cpp-font-lock.el ends here
