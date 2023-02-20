# Kafka Docker

Kafka Docker image built on top of [ubuntu-base:18.04](https://github.com/VladislavNagaev/Ubuntu-Docker.git)


## Quick Start

Build image:
~~~
make --file Makefile 
~~~

Depoyment of containers:
~~~
docker-compose -f docker-compose-kraft.yaml up -d
~~~


## Technologies
---
Project is created with:
* Apache Kafka version: 3.4.0
* Scala version: 2.13
* Docker verion: 20.10.22
* Docker-compose version: v2.11.1

