FROM php:7.4-cli-alpine

ARG USER=php-user
ENV HOME /home/$USER
ENV APP_KEY 0
ENV APP_ENV development
ENV PUSHER_APP_ID 0
ENV PUSHER_APP_KEY 0
ENV PUSHER_APP_SECRET 0
ENV PUSHER_APP_CLUSTER 0
ENV MIX_PUSHER_APP_KEY $PUSHER_APP_KEY
ENV MIX_PUSHER_APP_CLUSTER $PUSHER_APP_CLUSTER

WORKDIR $HOME

RUN adduser -D $USER; \
    apk add composer

COPY --chown=$USER:$USER . .

USER $USER

RUN cp .env.example .env; \
    composer install --no-dev --optimize-autoloader

EXPOSE 6001

ENTRYPOINT ["/bin/sh", "-c", "/bin/sh \"$HOME\"/run.sh"]
