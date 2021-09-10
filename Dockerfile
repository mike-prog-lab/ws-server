FROM php:7.4-cli-alpine

ARG USER=php-user
ENV HOME /home/$USER

WORKDIR $HOME

RUN adduser -D $USER; \
    apk add composer; \
    docker-php-ext-install mysqli pdo_mysql

COPY --chown=$USER:$USER . .

USER $USER

RUN cp .env.example .env; \
    composer install --no-dev --optimize-autoloader

EXPOSE 6001

ENTRYPOINT ["/bin/sh", "-c", "/bin/sh \"$HOME\"/run.sh"]
