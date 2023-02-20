#!/bin/bash

COMMAND="${1:-}"

kafka-termination() {
    source /entrypoint/kafka-termination.sh $COMMAND
}

source /entrypoint/wait_for_it.sh

source /entrypoint/kafka-configure.sh

source /entrypoint/kafka-initialization.sh $COMMAND &

trap kafka-termination SIGTERM HUP INT QUIT TERM

# Wait for any process to exit
wait -n
