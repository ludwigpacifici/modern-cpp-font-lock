emacs?=emacs
emacs_options=-Q -batch
faceup_directory=faceup
byte_compilation=byte-compile-file

all: compile

compile:
	$(emacs) $(emacs_options) --eval="($(byte_compilation) \"modern-cpp-font-lock.el\")"

prepare_test:
	wget --no-clobber --directory-prefix $(faceup_directory) \
https://raw.githubusercontent.com/Lindydancer/faceup/master/faceup.el

compile_test:
	$(emacs) $(emacs_options) --eval="($(byte_compilation) \"$(wildcard $(faceup_directory)/*.el)\")"

test: prepare_test compile compile_test
	@echo "Using $(shell which $(emacs))"
	@echo "$(shell $(emacs) --version)"
	$(emacs) $(emacs_options) -l ert -l modern-cpp-font-lock-setup-test.el -f ert-run-tests-batch-and-exit

clean:
	rm -rf *.elc $(faceup_directory)
