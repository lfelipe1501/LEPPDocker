FROM python:3.13-slim

LABEL version="1.0" maintainer="Luis Felipe <lfelipe1501@gmail.com>"

# Optional Configuration Parameter
ARG TZ\
    USR_ID\
    GRP_ID

# Set Variables
ENV CHARSET=UTF-8\
    TZ=${TZ}\
    USR_ID=${USR_ID}\
    GRP_ID=${GRP_ID}

# Create user to protect container
RUN groupadd -g $GRP_ID pyusr\
    && useradd pyusr --shell /usr/sbin/nologin\
    -u $USR_ID -g pyusr

# Init Python Configuration
RUN mkdir /app && chmod 777 /app
COPY entrypoint.sh /entrypoint.sh

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y openssl\
    bash-completion zip unzip nano gnupg2 debian-archive-keyring\
    curl wget net-tools lsb-release ca-certificates gcc libc6-dev libpq5\
    && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y\
    && rm -rf /var/lib/apt/lists/*\
    && rm -rf /tmp/* /var/tmp/*\
    && chown -R $USR_ID:$GRP_ID /app\
    && chown -R $USR_ID:$GRP_ID /var/run\
    && chmod -R 777 /var/run\
    && chown -R $USR_ID:$GRP_ID /var/cache\
    && chown $USR_ID:$GRP_ID /etc/localtime\
    && chown $USR_ID:$GRP_ID /etc/timezone\
    && chmod 777 /entrypoint.sh\
    && chown $USR_ID:$GRP_ID /entrypoint.sh

USER pyusr
WORKDIR /app

# 8000 8001 (Administracion)
EXPOSE 8000 8001

# Run the application
CMD ["/entrypoint.sh"]

