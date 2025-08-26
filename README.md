

# 📡 Event-Driven Microservices Simulation (Kafka / SNS-SQS)

## Overview

This project simulates an event-driven architecture using microservices that communicate asynchronously via Kafka or a mock SNS-SQS setup. It’s built entirely with local tools and Docker, ideal for showcasing cloud engineering principles without using actual cloud services.

## 🧩 Architecture

- **Producer Service**: Emits events (e.g., user signup, order placed).
- **Message Broker**: Kafka (via Docker) or simulated SNS-SQS using Redis or local queues.
- **Consumer Services**: Listen for specific event types and react accordingly (e.g., send email, update database).
- **Monitoring**: Optional Prometheus + Grafana stack for metrics.

## 🔧 Tech Stack

- Docker & Docker Compose
- Kafka (via Bitnami or Confluent image) or Redis-based queue
- Python / Node.js / Go microservices
- Optional: Prometheus, Grafana, Loki for observability

## 🚀 Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/yourusername/event-driven-microservices-sim.git
cd event-driven-microservices-sim
```

### 2. Start Kafka Broker

```bash
docker-compose up -d kafka zookeeper
```

Or use Redis for SNS-SQS simulation:

```bash
docker-compose up -d redis
```

### 3. Run Microservices

Each service is containerized. Start them with:

```bash
docker-compose up -d producer consumer-email consumer-db
```

### 4. Trigger Events

Send a test event from the producer:

```bash
curl -X POST http://localhost:3000/event -H "Content-Type: application/json" -d '{"type": "user_signup", "data": {"email": "test@example.com"}}'
```

### 5. Observe Consumer Logs

Check logs to verify event handling:

```bash
docker logs consumer-email
```

## 📊 Optional Monitoring

To enable observability:

```bash
docker-compose up -d prometheus grafana
```

Access Grafana at `http://localhost:3000` and import dashboards.

## 📁 Folder Structure

```
.
├── docker-compose.yml
├── producer/
│   └── app.py
├── consumer-email/
│   └── app.py
├── consumer-db/
│   └── app.py
├── kafka/
│   └── config/
└── monitoring/
    ├── prometheus.yml
    └── grafana/
```

## 🧪 Test Scenarios

- Simulate burst traffic and observe queue behavior
- Introduce consumer failure and verify retry logic
- Add new event types and extend consumer logic

## 📚 Learning Outcomes

- Understand asynchronous communication patterns
- Practice decoupling services via event streams
- Gain hands-on experience with Kafka/SNS-SQS simulation
- Build resilient, observable microservice systems

---
                        +------------------+
                        |  Producer Service |
                        |  (e.g. Order API) |
                        +--------+---------+
                                 |
                                 |  🔊 Publish Event
                                 v
                      +------------------------+
                      |   Message Broker Layer |
                      |  Kafka / Redis Queue   |
                      +------------------------+
                                 |
                +----------------+----------------+
                |                                 |
        +---------------+                 +---------------+
        | Consumer: Email|                 | Consumer: DB   |
        | Notification   |                 | Update Service |
        +---------------+                 +---------------+
                |                                 |
        +---------------+                 +---------------+
        | Send Email     |                 | Write to DB    |
        +---------------+                 +---------------+

