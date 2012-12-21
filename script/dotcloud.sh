#!/bin/sh
export ENVIRONMENT_FILE="/home/dotcloud/environment.yml";
export MOJO_LOG_LEVEL="info";

# export environment.yml as shell variables
$( perl -p -e's/:\s+/=/;s/^/export /' $ENVIRONMENT_FILE );

if [ "x$DOTCLOUD_PROJECT" = "pratter_test" ]; then
    export MOJO_LOG_LEVEL="debug";
fi

exec /home/dotcloud/current/script/pratter daemon --listen "http://*:$PORT_WWW";

