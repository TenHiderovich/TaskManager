start:
	docker-compose up

bash:
	docker-compose run --rm web bash

rubocop:
	docker-compose run --rm web bash -c "rubocop"

rubocop-a:
	docker-compose run --rm web bash -c "rubocop -a"

lint:
	docker-compose run --rm web bash -c "yarn lint"

lint-fix:
	docker-compose run --rm web bash -c "yarn lint --fix"

tests:
	docker-compose run --rm web bash -c "rails test"