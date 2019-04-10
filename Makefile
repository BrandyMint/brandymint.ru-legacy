setup: bundle bower

npm:
	npm install -g bower

bundle:
	bundle install

deploy: setup build # build static and deploy
	bundle exec cap production deploy

.PHONY: ./source/vendor/components/
bower: npm
	bower install

build: # builds a static site in `build` folder.
	bundle exec middleman build --verbose

start: # starts a server on `0.0.0.0:4567` (liveupdate included).
	bundle exec middleman

.DEFAULT_GOAL := deploy
