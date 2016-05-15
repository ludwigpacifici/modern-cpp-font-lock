[![License GPL 3][badge-license]](http://www.gnu.org/licenses/gpl-3.0.txt)

# Modern C++ font-lock for Emacs #

Syntax coloring support for "Modern C++" - until C++17 and TS (Technical Specification). It is recommended to use it in addition with the `c++-mode` major-mode.

## Preview ##

Soon.

## Installation ##

### Manual ###

#### Global setup ####

Download `modern-cpp-font-lock.el` into a directory of your [load-path][load-path]. Place the following lines in a suitable init file:

    (require 'modern-cpp-font-lock)
    (modern-c++-font-lock-global-mode t)

`modern-c++-font-lock-mode` will be activated for buffers using the `c++-mode` major-mode.

#### Local ####

For the current buffer, the minor-mode can be turned on/off via the command:

<kbd>M-x modern-c++-font-lock-mode [RET]</kbd>

### Melpa ###

Soon.

## Mode line ##

When `modern-c++-font-lock-mode` is activated, `mc++fl` is displayed.

Happy coding! :skull:

[Lud][lud]

[lud]: http://lud.cc
[load-path]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html
[badge-license]: https://img.shields.io/badge/license-GPL_3-green.svg
