<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/logo.png"/></p>
***

[![License GPL 3](https://img.shields.io/badge/license-GPL_3-green.svg)](http://www.gnu.org/licenses/gpl-3.0.txt)
[![MELPA](http://melpa.org/packages/modern-cpp-font-lock-badge.svg)](http://melpa.org/#/modern-cpp-font-lock)
[![Build Status](https://travis-ci.org/ludwigpacifici/modern-cpp-font-lock.svg?branch=master)](https://travis-ci.org/ludwigpacifici/modern-cpp-font-lock)

[![Donate Paypal](https://img.shields.io/badge/Donate-Paypal-lightgrey.svg)](https://www.paypal.me/ludwigpacifici)
[![Donate Bitcoin](https://img.shields.io/badge/Donate-Bitcoin-lightgrey.svg)](https://www.coinbase.com/lud)

Syntax highlighting support for "Modern C++" - until C++17 and Technical Specification. This package aims to provide a simple highlight of the C++ language without dependency.

It is recommended to use it in addition with the `c++-mode` major mode for extra highlighting (user defined types, functions, etc.) and indentation.
***

# Preview #

`modern-c++-font-lock-mode` is enabled:

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/mc%2B%2Bfl-on.png" width="640" /></p>

`modern-c++-font-lock-mode` is disabled:

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/mc%2B%2Bfl-off.png" width="640" /></p>

Using `GNU Emacs 24.5.1` and `CC Mode version 5.32.5`.

# Installation #

## Melpa ##

`modern-cpp-font-lock` is available on the major `package.el` community maintained repo - [MELPA](http://melpa.org).

You can install it with the following command:

<kbd>M-x</kbd> `package-install` <kbd>[RET]</kbd> `modern-cpp-font-lock` <kbd>[RET]</kbd>

In your init Emacs file add:

    (add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)

or:

    (modern-c++-font-lock-global-mode t)

## Manual ##

### Global setup ###

Download `modern-cpp-font-lock.el` into a directory of your [load-path][load-path]. Place the following lines in a suitable init file:

    (require 'modern-cpp-font-lock)
    (modern-c++-font-lock-global-mode t)

`modern-c++-font-lock-mode` will be activated for buffers using the `c++-mode` major-mode.

[load-path]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html

### Local ###

For the current buffer, the minor-mode can be turned on/off via the command:

<kbd>M-x</kbd> `modern-c++-font-lock-mode` <kbd>[RET]</kbd>

# Configuration #

You can modify the following lists to recognize more words or set it to `nil` to partially disable font locking:

 * `modern-c++-attributes` - `[[deprecated]]`, `[[noreturn]]`, `[[optimize_for_synchronized]]`...
 * `modern-c++-keywords` - `if`, `constexpr`, `noexcept`...
 * `modern-c++-operators` - `...`
 * `modern-c++-preprocessors` - `#define`, `__LINE__`, `__cplusplus`...
 * `modern-c++-types` - `bool`, `char`, `double`...

Set to `t` (default value) to enable the following options or otherwise to `nil`:

 * `modern-c++-literal-boolean` - `false`, `true`
 * `modern-c++-literal-integer` - `0b101010`, `18446744073709550592LLU`, `0XdeadBABEu`...
 * `modern-c++-literal-null-pointer` - `nullptr`
 * `modern-c++-literal-string` - `R"xyz()")xyz"`, `L"hello\ngoodbye"`, `"abcd"`...

## Example: Enable font-lock for more operators ##

By default, operators are no font locked (to avoid the _christmas tree_ effect). However, you could argue they can be overloaded and it could make sense to highlight all/some of them. It is a perfect example to show you how to customize this minor-mode:

With `c++-mode` and `modern-c++-font-lock-mode` enabled, you will see by default:

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/all-operator-off-sample.png"/></p>

Add `(add-to-list 'modern-c++-operators "=")` in your init file to enable extra font locking for operators. Now, `=` is highlighted:

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/all-operator-on-sample.png"/></p>

## Example: Disable font-lock for attributes ##

You do not like some part of the font-locking? Fair enough. Let's disable the syntax highlighting for C++ attributes.

With `c++-mode` and `modern-c++-font-lock-mode` enabled, you will see by default:

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/attributes-on.png"/></p>

Add `(setq modern-c++-attributes nil)` in your init file to disable font locking for C++ attributes. Now, `[[maybe_unused]]` is no more highlighted:

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/attributes-off.png"/></p>

# Mode line #

When `modern-c++-font-lock-mode` is activated, `mc++fl` is displayed.

<p align="center"><img src="https://raw.githubusercontent.com/ludwigpacifici/modern-cpp-font-lock/master/img/mode-line.png" width="640" /></p>

# Feedback #

Do not hesitate to ask questions or share suggestions.

Happy coding!

[Lud](http://lud.cc)
