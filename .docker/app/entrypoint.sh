#!/bin/bash
set -e
cmd="$@"
ve_path="./venv"
src_path="./src" # Isso vem do docker-compose.yml
default_cmd="./venv/bin/python ${src_path}/manage.py runserver 0.0.0.0:8000"
requirements=("db 3306")


# Se pressionar CTRL + C, chame a função ctlr_c
trap ctrl_c INT
function ctrl_c() {
    echo ""
    echored
    echo -e "Saindo pelo CTRL + C"
    exit -1
}


create_virtualenv_if_does_not_exists() {
	num_files=$(find ${ve_path} -maxdepth 1 -mindepth 1 | wc -l)

	if [ "${num_files}" == "0" ]; then
		echo "Creating virtualenv"
		virtualenv -p /usr/local/bin/python ${ve_path}
	fi
}

install_project_python_requirements() {
	echo "Installing python requirements"
	${ve_path}/bin/pip install -r "./src/requirements.txt"
}

start_new_project_if_folder_is_empty() {
	num_files=$(find ${src_path} -maxdepth 1 -mindepth 1 -not -name requirements.txt | wc -l)

    if [ "${num_files}" == "0" ]; then
        echo "No project files found on '${src_path}'! Starting a new django project named '${DJANGO_PROJECT_NAME}'"
        DJANGO_SETTINGS_MODULE= ${ve_path}/bin/django-admin startproject ${DJANGO_PROJECT_NAME} ${src_path}

    fi
}

handle_django_migrations(){
	if [ "${ENVIRONMENT}" == "development" ]; then
		echo "Creating migrations"
		${ve_path}/bin/python ${src_path}/manage.py makemigrations
	fi

	echo "Applying migrations"
	${ve_path}/bin/python ${src_path}/manage.py migrate --noinput
}

handle_django_fixtures(){
	if [ "${ENVIRONMENT}" == "development" ]; then
		echo "Looking for fixtures to import"
		fixtures="$(find ${src_path} -wholename */fixtures/initial_*.json)" 
		if [ -z "${fixtures}" ]; then
			echo "No fixtures matching 'initial_*.json' found"
		else
			for fixture in ${fixtures}
			do
				echo "loading ${fixture}"
				${ve_path}/bin/python ${src_path}/manage.py loaddata ${fixture}
			done
		fi
	fi
}

wait_requirements_for_this_container() {
	missing_requirement=true
	while [ "${missing_requirement}" == "true" ]
	do 
	    missing_requirement=false
	    sleep 1
	    for req in "${requirements[@]}"
	    do 
		if ! nc -z $req
		then
		    echo "Waiting for ${req} to be up"
		    missing_requirement=true
		else
		    echo "${req} is up!"
		fi
	    done
	done

	>&2 echo "All required services are up. Let's move on..!"
}


echo "Running $0 (cwd is '$(pwd)') "


if [ "${cmd}" == "default" ]; then
	echo "Running default command"	

	create_virtualenv_if_does_not_exists && \
	install_project_python_requirements && \
	start_new_project_if_folder_is_empty && \
	wait_requirements_for_this_container && \
	handle_django_migrations && \
	handle_django_fixtures && \
	exec ${default_cmd}
else 
	echo "Running requested command '${cmd}'"
	exec $cmd
fi


