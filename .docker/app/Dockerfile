FROM python:3.5

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG FTP_PROXY
ARG ALL_PROXY
ARG NO_PROXY
ARG http_proxy
ARG https_proxy
ARG ftp_proxy
ARG all_proxy
ARG no_proxy
ARG CONTAINER_USER_ID
ARG CONTAINER_GROUP_ID
ARG CONTAINER_USER_NAME

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 0

RUN echo -e "\n\n\tPrinting build ENV:\n\n$(env)\n\n"

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		python-virtualenv \
		netcat \
		libmysqlclient-dev \
		python3-dev && \
	apt-get autoremove -y 

COPY ./entrypoint.sh /entrypoint.sh

RUN useradd -U -u ${CONTAINER_USER_ID} -m -d /home/${CONTAINER_USER_NAME} -s /bin/bash ${CONTAINER_USER_NAME} 

COPY ./* /home/${CONTAINER_USER_NAME}/
RUN mkdir /home/${CONTAINER_USER_NAME}/venv

EXPOSE 8000
VOLUME /home/${CONTAINER_USER_NAME}
VOLUME /home/${CONTAINER_USER_NAME}/venv
# opcional src do pydev para remote debug
VOLUME /usr/src/pydev/pysrc/  

USER ${CONTAINER_USER_NAME}
WORKDIR /home/${CONTAINER_USER_NAME}

ENV IS_DOCKER true

CMD ["/entrypoint.sh", "default"]