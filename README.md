# Base container to start a project using Django with MySQL (and a phpMyAdmin)

## How to use it?
Adjust variables in .env file
* run `docker-compose build`
* run `docker-compose up`

## How to install extra requirements?
Define extra requirements on src/requirements.txt and restart the container to have them installed.

## How to run the manage.py?
`~/django-base$ docker-compose exec app venv/bin/python src/manage.py <command>`
* eg. `~/django-base$ docker-compose exec app venv/bin/python src/manage.py createsuperuser`

