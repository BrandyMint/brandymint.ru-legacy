setup: bundle bower

npm:
	npm install -g bower

bundle:
	bundle install

deploy: build # build static only
	@echo "Deploy target removed. Use 'make build' and deploy manually."

.PHONY: ./source/vendor/components/
bower: npm
	bower install

build: # builds a static site in `build` folder.
	bundle exec middleman build --verbose

PORT ?= 3000

start: # starts a server on `0.0.0.0:${PORT}` (liveupdate included).
	bundle exec middleman -p ${PORT}

.DEFAULT_GOAL := deploy
