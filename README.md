# Base container to start a project using Django with MySQL (and a phpMyAdmin)

## How to use it?
* Adjust variables in __.env__ file
* run `docker-compose build`
* run `docker-compose up`
* Access it on [http://localhost:8000](http://localhost:8000)


## How to install extra requirements?
Define extra requirements on __src/requirements.txt__ and restart the container to have them installed.

## How to run the manage.py?
`~/django-base$ docker-compose exec app venv/bin/python src/manage.py <command>`
* eg. `~/django-base$ docker-compose exec app venv/bin/python src/manage.py createsuperuser`

## How to access PHPMyAdmin
* Access it on [http://localhost:9090](http://localhost:9090)
