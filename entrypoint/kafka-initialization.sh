#!/bin/bash

COMMAND="${1:-}"


if [ "${COMMAND}" == "kafka-kraft" ]; then

    echo "Starting Kafka with KRaft ..."

    # run cluster at first time
    if [ "`ls -A ${CONF_KRAFT_SERVER_log_dirs}`" == "" ]; then

        echo "Formatting Kafka logs directory: ${CONF_KRAFT_SERVER_log_dirs}"

        # Generate a Cluster UUID
        KAFKA_CLUSTER_ID="$(${KAFKA_HOME}/bin/kafka-storage.sh random-uuid)"

        # Format Log Directories
        ${KAFKA_HOME}/bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c ${KAFKA_CONF_DIR}/kraft/server.properties

    fi

    # Start the Kafka Server
    ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_CONF_DIR}/kraft/server.properties

fi

if [ "${COMMAND}" == "kafka" ]; then

    echo "Starting Kafka ..."

    # Start the Kafka broker service
    ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_CONF_DIR}/server.properties

fi

if [ "${COMMAND}" == "zookeeper" ]; then

    echo "Starting ZooKeeper ..."

    # Start the ZooKeeper service
    ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_CONF_DIR}/zookeeper.properties

fi


exit $?
