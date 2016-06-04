emacs?=emacs
emacs_opt=-q -batch -l
faceup_dir=faceup

all: prepare compile test

prepare:
	wget -P $(faceup_dir) https://raw.githubusercontent.com/Lindydancer/faceup/master/faceup.el

compile:
	$(emacs) $(emacs_opt) compile.el

test:
	@echo "Using $(shell which $(emacs))"
	@echo "$(shell $(emacs) --version)"
	$(emacs) $(emacs_opt) modern-cpp-font-lock-test-setup.el

clean:
	rm -rf *.elc test/*.elc $(faceup_dir)
