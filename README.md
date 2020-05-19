<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/logo.png"/></p>

[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
[![MELPA](http://melpa.org/packages/modern-cpp-font-lock-badge.svg)](http://melpa.org/#/modern-cpp-font-lock)
[![Build Status](https://travis-ci.org/ludwigpacifici/modern-cpp-font-lock.svg?branch=master)](https://travis-ci.org/ludwigpacifici/modern-cpp-font-lock)

[![Donate Paypal](https://img.shields.io/badge/Donate-Paypal-lightgrey.svg)](https://www.paypal.me/ludwigpacifici)

Syntax highlighting support for "Modern C++" - until C++20 and Technical Specification. This package aims to provide a simple highlight of the C++ language without dependency.

It is recommended to use it in addition with the `c++-mode` major mode for extra highlighting (user defined types, functions, etc.) and indentation.

# Preview

With `modern-c++-font-lock-mode`:

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/mc%2B%2Bfl-on.png" /></p>

Using `GNU Emacs 27.0.50` and `CC Mode version 5.33.2`.

# Installation

## Melpa

`modern-cpp-font-lock` is available on the major `package.el` community maintained repo - [MELPA](http://melpa.org).

You can install it with the following command:

<kbd>M-x</kbd> `package-install` <kbd>[RET]</kbd> `modern-cpp-font-lock` <kbd>[RET]</kbd>

In your init Emacs file add:

    (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

or:

    (modern-c++-font-lock-global-mode t)

## `use-package`

In your init Emacs file add:

    (use-package modern-cpp-font-lock
      :ensure t)

## Manual

### Global setup

Download `modern-cpp-font-lock.el` into a directory of your [load-path][load-path]. Place the following lines in a suitable init file:

    (require 'modern-cpp-font-lock)
    (modern-c++-font-lock-global-mode t)

`modern-c++-font-lock-mode` will be activated for buffers using the `c++-mode` major-mode.

[load-path]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html

### Local

For the current buffer, the minor-mode can be turned on/off via the command:

<kbd>M-x</kbd> `modern-c++-font-lock-mode` <kbd>[RET]</kbd>

# Configuration

## C++ Language

You can modify the following lists to recognize more words or set it to `nil` to partially disable font locking:

 * `modern-c++-attributes` - `[[deprecated]]`, `[[noreturn]]`, [etc](http://en.cppreference.com/w/cpp/language/attributes).
 * `modern-c++-keywords` - `if`, `constexpr`, `noexcept`, [etc](http://en.cppreference.com/w/cpp/keyword).
 * `modern-c++-operators` - `...`
 * `modern-c++-preprocessors` - `#define`, `__LINE__`, `__cplusplus`, [etc](http://en.cppreference.com/w/cpp/preprocessor).
 * `modern-c++-types` - `bool`, `char`, `double`, [etc](http://en.cppreference.com/w/cpp/language/type).

Set to `t` (default value) to enable the following options or otherwise to `nil`:

 * `modern-c++-literal-boolean` - `false`, `true`
 * `modern-c++-literal-integer` - `0b101010`, `18446744073709550592LLU`, `0XdeadBABEu`, [etc](http://en.cppreference.com/w/cpp/language/integer_literal).
 * `modern-c++-literal-null-pointer` - `nullptr`
 * `modern-c++-literal-string` - `R"xyz()")xyz"`, `L"hello\ngoodbye"`, `"abcd"`, [etc](http://en.cppreference.com/w/cpp/language/string_literal).

Configure the following list to customize font locking for literal integers:

 * `modern-c++-literal-binary-prefix-face`
 * `modern-c++-literal-binary-infix-face`
 * `modern-c++-literal-binary-suffix-face`
 * `modern-c++-literal-octal-prefix-face`
 * `modern-c++-literal-octal-infix-face`
 * `modern-c++-literal-octal-suffix-face`
 * `modern-c++-literal-hex-prefix-face`
 * `modern-c++-literal-hex-infix-face`
 * `modern-c++-literal-hex-suffix-face`
 * `modern-c++-literal-dec-infix-face`
 * `modern-c++-literal-dec-suffix-face`

## C++ standard library

Set to `t` (default value) to enable the following font lock options. Otherwise use `nil`:

 * `modern-c++-stl-cstdint` - Define the header [`<cstdint>`](http://en.cppreference.com/w/cpp/header/cstdint)

# Mode line

When `modern-c++-font-lock-mode` is activated, `mc++fl` is displayed.

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/mode-line.png" width="640" /></p>

# [Wiki](https://github.com/ludwigpacifici/modern-cpp-font-lock/wiki)

The Wiki is available: https://github.com/ludwigpacifici/modern-cpp-font-lock/wiki

# Testing

Font-lock keywords are tested with the [faceup](https://github.com/Lindydancer/faceup) package of [Anders Lindgren](https://github.com/Lindydancer).

# Feedback

If you find a bug, please check if you can reproduce with `c++-mode` only. If it is the case, send your bug upstream to [CC Mode](http://cc-mode.sourceforge.net/)

Do not hesitate to ask questions or share suggestions.

Happy coding!

[Lud](https://lud.cc)
