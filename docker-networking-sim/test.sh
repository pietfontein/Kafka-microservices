#!/bin/bash

echo "Testing internal network connectivity..."
docker-compose exec client ping -c 2 192.168.100.10
docker-compose exec client ping -c 2 192.168.100.20

echo "Testing external connectivity through NAT..."
docker-compose exec client ping -c 2 10.0.0.100

echo "Testing complete!"
