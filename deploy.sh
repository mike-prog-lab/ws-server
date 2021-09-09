docker rm -f prw-ws-server

if ! docker network ls | grep -q prw-ws-net
then
    docker network create prw-ws-net
fi

if ! docker ps -a | grep -q prw-ws-database
then
    docker run -d \
    --name prw-ws-database \
    --network prw-ws-net \
    --mount type=bind,source="$MYSQL_PATH",target=/var/lib/mysql \
    --env MYSQL_DATABASE="prw-ws-data" \
    --env MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD"\
    --env MYSQL_USER="$DB_USERNAME"\
    --env DB_PASSWORD="$DB_PASSWORD" \
    mysql:8
fi

docker run -d \
    --name prw-ws-server \
    -p 6001:6001 \
    --network prw-ws-net \
    --env APP_KEY="$APP_KEY" \
    --env APP_ENV="$APP_ENV" \
    --env DB_HOST="prw-ws-database" \
    --env DB_DATABASE="$DB_DATABASE" \
    --env DB_USERNAME="$DB_USERNAME" \
    --env DB_PASSWORD="$DB_PASSWORD" \
    --env PUSHER_APP_ID="$PUSHER_APP_ID" \
    --env PUSHER_APP_KEY="$PUSHER_APP_KEY" \
    --env PUSHER_APP_SECRET="$PUSHER_APP_SECRET" \
    --env PUSHER_APP_CLUSTER="$PUSHER_APP_CLUSTER" \
    --env MIX_PUSHER_APP_KEY="$MIX_PUSHER_APP_KEY" \
    --env MIX_PUSHER_APP_CLUSTER="$MIX_PUSHER_APP_CLUSTER" \
    docker.pkg.github.com/contact-funnels-ltd/prw-websocket-server/prw-ws-server:"$APP_VERSION"

