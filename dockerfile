FROM confluentinc/cp-kafka:7.4.0

# Copy the topics creation script
COPY create-topics.sh /usr/local/bin/create-topics.sh
RUN chmod +x /usr/local/bin/create-topics.sh

# Add wait script to ensure Kafka is ready
RUN apt-get update && apt-get install -y netcat

COPY wait-for-kafka.sh /usr/local/bin/wait-for-kafka.sh
RUN chmod +x /usr/local/bin/wait-for-kafka.sh

CMD ["/usr/local/bin/wait-for-kafka.sh"]