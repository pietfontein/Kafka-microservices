#!/bin/bash

# Start all containers
docker-compose up -d

# Configure the router
docker-compose exec router /bin/sh -c "sysctl -w net.ipv4.ip_forward=1"
docker-compose exec router /bin/sh -c "iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE"

# Configure routes on internal hosts
for service in web db client; do
  docker-compose exec $service /bin/sh -c "ip route add 10.0.0.0/24 via 192.168.100.1"
done

echo "Network simulation setup complete!"
