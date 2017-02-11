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

## Which versions?
* app and db containes S.O. are Debian 8
* Python interpreter is 3.5.3
* Python packages:
** Django==1.10.5
** mysqlclient==1.3.9
* MySQL Server 5.7.17 (charset UTF-8 Unicode (utf8))
* PHPMyAdmin version is 4.6.5.2 (on PHP 4.6.28)
