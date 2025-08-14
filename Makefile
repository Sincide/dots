SHELL := /usr/bin/env bash

.PHONY: deps install uninstall link unlink reload check lint fmt

deps:
	./scripts/check-deps.sh

install:
	./install.sh

uninstall:
	./uninstall.sh

link:
	./scripts/stow.sh

unlink:
	./scripts/stow.sh --unstow

reload:
	systemctl --user restart quickshell.service

check:
	@command -v shellcheck >/dev/null 2>&1 && shellcheck scripts/*.sh || echo 'shellcheck missing'

lint: check

fmt:
	@command -v shfmt >/dev/null 2>&1 && shfmt -w scripts/*.sh || echo 'shfmt missing'
