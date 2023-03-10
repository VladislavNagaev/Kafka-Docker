#!/bin/bash

COMMAND="${1:-}";

if [ "${COMMAND}" == "kafka-kraft" ]; then

    echo -e "${blue_b}Ending Kafka with KRaft ...${reset_font}";

    ${KAFKA_HOME}/bin/kafka-server-stop.sh;

fi;

if [ "${COMMAND}" == "kafka" ]; then

    echo -e "${blue_b}Ending Kafka ...${reset_font}";

    ${KAFKA_HOME}/bin/kafka-server-stop.sh;

fi;

if [ "${COMMAND}" == "zookeeper" ]; then

    echo -e "${blue_b}Ending ZooKeeper ...${reset_font}";

    ${KAFKA_HOME}/bin/zookeeper-server-stop.sh;

fi;

exit $?;
