#docker rm -f prw-ws-server

docker run \
    --name prw-ws-server \
    -p 6001:6001 \
    --env APP_KEY="$APP_KEY" \
    --env APP_ENV="$APP_ENV" \
    --env PUSHER_APP_ID="$PUSHER_APP_ID" \
    --env PUSHER_APP_KEY="$PUSHER_APP_KEY" \
    --env PUSHER_APP_SECRET="$PUSHER_APP_SECRET" \
    --env PUSHER_APP_CLUSTER="$PUSHER_APP_CLUSTER" \
    --env MIX_PUSHER_APP_KEY="$MIX_PUSHER_APP_KEY" \
    --env MIX_PUSHER_APP_CLUSTER="$MIX_PUSHER_APP_CLUSTER" \
    docker.pkg.github.com/contact-funnels-ltd/prw-websocket-server/prw-ws-server:"$APP_VERSION"

