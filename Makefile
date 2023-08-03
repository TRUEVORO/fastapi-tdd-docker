run:
	docker-compose up -d --build

down:
	docker-compose down -v

prune:
	docker system prune -a -f --volumes

logs:
	docker-compose exec logs web

db:
	docker-compose exec web aerich upgrade

style:
	docker-compose exec web black .
	docker-compose exec web isort .
	docker-compose exec web flake8 .

unittests:
	docker-compose exec web pytest -k "unit" -n auto -p no:cacheprovider

tests:
	docker-compose exec web python -m pytest -p no:cacheprovider

coverage:
	docker-compose exec web python -m pytest -p no:cacheprovider --cov="." --cov-report html

psql:
	docker-compose exec web-db psql -U postgres

app:
	make run
	make style
	make db
	make tests
