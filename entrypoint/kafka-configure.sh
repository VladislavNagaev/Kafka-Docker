#!/bin/bash

echo -e "${blue_b}Kafka-node configuration started ...${reset_font}";


function configure_properties() {

    local path=$1;
    local envPrefix=$2;

    local var;
    local value;
    
    echo -e "${cyan_b}Configuring $path${reset_font}";

    for c in `printenv | perl -sne 'print "$1 " if m/^${envPrefix}_(.+?)=.*/' -- -envPrefix=$envPrefix`; do 

        name=`echo ${c} | perl -pe 's/___/-/g; s/__/@/g; s/_/./g; s/@/_/g;'`;
        var="${envPrefix}_${c}";
        value=${!var};

        local escapedValue=$(echo $value | sed 's/\//\\\//g');

        echo -e "${green} - Setting $name=$value${reset_font}";

        if [[ -n "$(sed -n "/^#\? *\($name\) *=.*/ p" $path)" ]]; then
            sed -i "s/^#\? *\($name\) *=.*/\1=$escapedValue/g" $path;
        else
            echo -e "\n$name=$value" | tee -a ${path} > /dev/null;
        fi;

    done;
};


if ! [ -z ${KAFKA_CONF_DIR+x} ]; then
    
    configure_properties ${KAFKA_CONF_DIR}/kraft/server.properties CONF_KRAFT_SERVER;
    configure_properties ${KAFKA_CONF_DIR}/server.properties CONF_SERVER;
    configure_properties ${KAFKA_CONF_DIR}/zookeeper.properties CONF_ZOOKEEPER;

fi;


echo -e "${blue_b}Kafka-node configuration completed!${reset_font}";
