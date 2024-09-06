# Docker Compose LEPP stack

This repository contains a little `docker compose` configuration to start a `LEPP (Linux, Nginx, Python, PostgreSQL)` stack.

## Details

The following versions are used.

* Python latest avaliable (uWSGI) - With WSGI server
* Nginx latest avaliable with [NGINX-UI DASHBOARD](https://nginxui.com/)
* PostgreSQL latest avaliable

For the nginx container, a Dockerfile is used, where ALPINE is used as a base image and is adjusted according to the best security and configuration practices for this service.
For the python container, a Dockerfile is used, where Official Python Debian small is used as a base image and is adjusted according to the best security and configuration practices for this service.

The versions used in these containers are the latest available for each official package of the indicated service, if you want to use a different or specific version you can edit the dockerfile files of each container in the `config` folder or if you want to add new commands within each container, extensions, services, etc., you can edit each dockerfile of each of them to customize it according to your needs.

PostgreSQL container use the official DockerHub containers so if you need something specific, you can use the official documentation of these containers and adjust it in the docker-compose.yml

## Configuration

The __NGINX__ configuration can be found in `data/nginx/`.

The `app` folder is a static path and you can upload the files of your applications in real time to be deployed and displayed by the nginx and python(uWSGi) service.
You can create multiple virtualhost inside `data/nginx/sites-avaliable/` in separate files `.conf` if you want, after this, activate them from the nginx-ui dashboard through port 81 or domain name or by connecting to the container and creating static links to the files in the nginx sites-enabled folder.

The __Python__ configuration can be found in `config/python/`.

You can set the desired python version from the Dockerfile which is located in the `config/python` folder

The __PostgreSQL__ configuration file postgresql.conf can be found in `config/pgsql/`.

You can also set the following environment variables, for example in the included `.env` file:

| Key | Description |
|-----|-------------|
|APP_NAME|The name used when creating a container.|
|USR|Set User ID for mariadb container o for any container.|
|GRP|Set Group ID for mariadb container o for any container.|
|ARCH_TYPE|Set the architecture of the nginx-ui package (x86_64 or arm).|
|NGXUI_PORT|Set nginx-ui port for Access.|
|WORKSPACE_TIMEZONE|The timezone used when creating a db container.|
|PYAP_PORT|The Python port for access.|
|PYAPSSL_PORT|The Python port for SSL access.|
|PG_DB|The PostgreSQL database used when creating the db container.|
|PG_USER|The PostgreSQL root user used when creating the db container.|
|PG_PASS|The PostgreSQL root user password used when creating the db container.|
|DATA_PATH_HOST|The path used when creating a db container to store the database data in a way accessible to the host server.|

> [!CAUTION]
> _**For WSL users**: If it is run in a windows dockerized environment with WLS2,
> it is NOT recommended to run on the windows desktop or in your windows system example: `/mnt/c/Users/lfelipe/Desktop/LEPPDocker/`,
> the good way is copy or clone the project inside the linux wls2 system preferably in the `HOME` folder of your user,
> because windows has problems with the partitions mounted within the linux subsystem example: `/mnt/c/Users/lfelipe/Desktop`
> it is a bad path and can lead to problems with docker_

## Usage

To use it, simply follow the following steps:

##### Clone this repository.

Clone this repository with the following command:
```bash
git clone https://github.com/lfelipe1501/LEPPDocker.git
```

#### Start the server.

> [!IMPORTANT]
> _**For PostgreSQL CONTAINER**: **BEFORE** running the project you **MUST DELETE** the file
> located in the folder: `data/pg_data/` to avoid problems with the container and data creation
> and you MUST also **Remember** to edit the variables in the `.env` file
> before starting the environment to adjust the formula to your preferences_

Start the server using the following command inside the directory you just cloned:
```console
docker compose up -d
```

## Restart the containers

If you make changes to the pyth and nginx config files (py, ini, conf, etc) you must restart each container to apply these changes, with the respective commands:

Where `{CONTAINER_NAME}` is one of:

* `{APP_NAME}-pyth`
* `{APP_NAME}-nginx`

`docker restart {CONTAINER_NAME}`

> example: `docker restart lfsys-nginx`

## Entering the containers

You can use the following command to enter a container:

Where `{CONTAINER_NAME}` is one of:

* `{APP_NAME}-pyth`
* `{APP_NAME}-nginx`
* `{APP_NAME}-pgdb`

`docker exec -ti {CONTAINER_NAME} bash`

> example: `docker exec -ti lfsys-pyth bash`

#### Stop the server.

Stop the server using the following command inside the directory you just cloned:
```console
docker compose down
```

### Contact / Social Media

*Get the latest News about Web Development, Open Source, Tooling, Server & Security*

[![Twitter](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/twitter.svg)](https://twitter.com/lfelipe1501)
[![Facebook](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/facebook.svg)](https://www.facebook.com/lfelipe1501)
[![Github](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/github.svg)](https://github.com/lfelipe1501)

### Development by

Developer / Author: [Luis Felipe Sanchez](https://github.com/lfelipe1501)
Company: [lfsystems](https://www.lfsystems.com.co)

