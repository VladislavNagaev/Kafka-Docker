# Образ на основе которого будет создан контейнер
FROM --platform=linux/amd64 ubuntu-base:18.04

LABEL maintainer="Vladislav Nagaev <vladislav.nagaew@gmail.com>"

# Изменение рабочего пользователя
USER root

# Выбор рабочей директории
WORKDIR /

ENV \ 
    # Задание версий сервисов
    SCALA_VERSION=2.13 \
    KAFKA_VERSION=3.4.0

ENV \
    # Задание домашних директорий
    KAFKA_HOME=/opt/kafka \
    KAFKA_CONF_DIR=/opt/kafka/config \
    # Полные наименования сервисов
    KAFKA_NAME=kafka_${SCALA_VERSION}-${KAFKA_VERSION}

ENV \
    # URL-адреса для скачивания
    KAFKA_URL=https://downloads.apache.org/kafka/${KAFKA_VERSION}/${KAFKA_NAME}.tgz \
    # Обновление переменных путей
    PATH=${KAFKA_HOME}/bin:${PATH}

RUN \
    # --------------------------------------------------------------------------
    # Установка базовых пакетов
    # --------------------------------------------------------------------------
    # Обновление путей
    apt --yes update && \
    apt install --no-install-recommends --yes gpg-agent && \
    # --------------------------------------------------------------------------
    # --------------------------------------------------------------------------
    # Установка Apache Kafka
    # --------------------------------------------------------------------------
    # Скачивание GPG-ключа
    curl -O https://downloads.apache.org/kafka/KEYS && \
    # Установка gpg-ключа
    gpg --import KEYS && \
    # Скачивание архива Apache Kafka
    curl -fSL ${KAFKA_URL} -o /tmp/${KAFKA_NAME}.tar && \
    # Скачивание PGP-ключа
    curl -fSL ${KAFKA_URL}.asc -o /tmp/${KAFKA_NAME}.tar.asc && \
    # Верификация ключа шифрования
    gpg --verify /tmp/${KAFKA_NAME}.tar.asc && \
    # Распаковка архива Apache Kafka в рабочую папку
    tar -xvf /tmp/${KAFKA_NAME}.tar -C $(dirname ${KAFKA_HOME})/ && \
    # Удаление исходного архива и ключа шифрования
    rm /tmp/${KAFKA_NAME}.tar* && \
    # Создание символической ссылки на Apache Kafka
    ln -s $(dirname ${KAFKA_HOME})/${KAFKA_NAME} ${KAFKA_HOME} && \
    # Рабочая директория Apache Kafka
    chmod a+rwx ${KAFKA_HOME} && \
    # Smoke test
    kafka-topics.sh --version && \
    # --------------------------------------------------------------------------
    # --------------------------------------------------------------------------
    # Удаление неактуальных пакетов, директорий, очистка кэша
    # --------------------------------------------------------------------------
    apt remove --yes gpg-agent && \
    apt --yes autoremove && \
    rm --recursive --force /var/lib/apt/lists/*
    # --------------------------------------------------------------------------

# Копирование файлов проекта
COPY ./entrypoint ${ENTRYPOINT_DIRECTORY}/

# Выбор рабочей директории
WORKDIR ${WORK_DIRECTORY}

# Точка входа
ENTRYPOINT ["/bin/bash", "/entrypoint/kafka-entrypoint.sh"]
CMD []
