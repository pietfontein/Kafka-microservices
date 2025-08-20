#!/bin/bash

echo "Waiting for Kafka to be ready..."

# Wait for Kafka to be available
while ! nc -z kafka 29092; do
  sleep 2
done

echo "Kafka is ready! Creating topics..."

# Execute the topics creation script
/usr/local/bin/create-topics.sh

echo "Kafka setup completed successfully!"