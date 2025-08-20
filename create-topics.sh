# kafka-setup/create-topics.sh
#!/bin/bash
echo "Creating Kafka topics..."

docker-compose exec kafka kafka-topics \
  --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 3 \
  --topic orders

docker-compose exec kafka kafka-topics \
  --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 3 \
  --topic payments

docker-compose exec kafka kafka-topics \
  --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 3 \
  --topic notifications

docker-compose exec kafka kafka-topics \
  --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 3 \
  --topic inventory

echo "Topics created successfully!"
