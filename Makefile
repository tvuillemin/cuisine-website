htmlhint:=./node_modules/.bin/htmlhint

.PHONY: lint

lint:
	$(htmlhint) src
