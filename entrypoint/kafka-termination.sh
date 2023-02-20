#!/bin/bash

COMMAND="${1:-}"


if [ "${COMMAND}" == "kafka-kraft" ]; then

    echo "Ending Kafka with KRaft ..."

    ${KAFKA_HOME}/bin/kafka-server-stop.sh

fi

if [ "${COMMAND}" == "kafka" ]; then

    echo "Ending Kafka ..."

    ${KAFKA_HOME}/bin/kafka-server-stop.sh

fi

if [ "${COMMAND}" == "zookeeper" ]; then

    echo "Ending ZooKeeper ..."

    ${KAFKA_HOME}/bin/zookeeper-server-stop.sh

fi

exit $?
