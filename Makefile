#* Variables
SHELL := /usr/bin/env bash

.PHONY: branchify
branchify:
	sed -i "s/^__version__\s*=\s*\"[0-9]*\.[0-9]*\.[0-9]*/&.dev$(shell date +%s)/g" datumaro/version.py

.PHONY: publish
publish:
	pip install twine build
	rm -rf dist
	python -m build
	twine upload dist/*.tar.gz --username $(PYPI_USERNAME) --password $(PYPI_PASSWORD)
	git checkout -- datumaro/version.py
	rm -rf dist

.PHONY: pre-release
pre-release: branchify publish
