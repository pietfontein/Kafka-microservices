#!/bin/bash

docker-compose down
docker network prune -f
docker volume prune -f
echo "All resources cleaned up!"
