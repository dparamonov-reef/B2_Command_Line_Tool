help: ## Show this help.
	@fgrep -h "##" Makefile | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
	@echo ""
	@echo "To see doc options, cd to doc and type \"make\""

.PHONY: setup
setup: ## Set up (to run tests) using your current python environment
setup: ## and enable pre-commit hook for this repo only.
	python -m pip install -r requirements-test.txt
	ln -s $(PWD)/pre-commit.sh .git/hooks/pre-commit || true

.PHONY: test
test:  ## Run unit tests
	./run-unit-tests.sh

.PHONY:
format:	## Format code using yapf
	yapf --verbose --in-place --parallel --recursive --exclude '*eggs/*' .

.PHONY: clean
clean: ## Remove stuff you can regenerate
	rm -rf b2sdk.egg-info build TAGS
	find . -name __pycache__ | xargs rm -rf
	find . -name \*~ -o -name \*.pyc | xargs rm -f
