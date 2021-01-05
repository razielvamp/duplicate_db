#!/bin/bash

cd ../docker

# remove data if already exists
docker rm -f $(cat docker-compose.yml | grep container_name | grep -v pg_admin | awk '{print $NF}')
docker rmi docker_data_exporter
sudo rm -fr pg_data/data_from pg_data/data_to

docker-compose up -d

cd -
