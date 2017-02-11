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

## And the versions..?
* app container is based on python:3.5 offical container (a Debian 8)
* db container uses the official image of mysql:5 (also a Debian 8)
* Python interpreter is 3.5.3
* Python packages:
** Django==1.10.5
** mysqlclient==1.3.9
* MySQL Server 5.7.17 (charset UTF-8 Unicode (utf8))
* PHPMyAdmin version is 4.6.5.2 (on PHP 4.6.28)
