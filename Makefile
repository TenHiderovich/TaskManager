start:
	docker-compose up

bash:
	docker-compose run --rm web bash

rubocop:
	docker-compose run --rm web bash -c "rubocop"

rubocopa-a:
	docker-compose run --rm web bash -c "rubocop -a"

lint:
	docker-compose run --rm web bash -c "yarn lint"

lint-fix:
	docker-compose run --rm web bash -c "yarn lint --fix"