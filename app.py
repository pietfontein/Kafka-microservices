# notification-service/app.py
from confluent_kafka import Consumer
import json
import logging
import smtplib
from email.mime.text import MIMEText

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Kafka configuration
KAFKA_BROKER = "kafka:9092"

consumer_conf = {
    'bootstrap.servers': KAFKA_BROKER,
    'group.id': 'notification-service-group',
    'auto.offset.reset': 'earliest'
}

consumer = Consumer(consumer_conf)

def send_email_notification(user_email, subject, message):
    """Simulate email sending"""
    logger.info(f"📧 Email to {user_email}: {subject} - {message}")
    # In production, integrate with real email service
    return True

def send_sms_notification(phone_number, message):
    """Simulate SMS sending"""
    logger.info(f"📱 SMS to {phone_number}: {message}")
    return True

def process_notifications():
    consumer.subscribe(['notifications', 'payments'])
    
    logger.info("Notification service started. Listening for events...")
    
    try:
        while True:
            msg = consumer.poll(1.0)
            
            if msg is None:
                continue
            if msg.error():
                logger.error(f"Consumer error: {msg.error()}")
                continue
            
            try:
                event = json.loads(msg.value())
                
                if event['event_type'] == 'PAYMENT_NOTIFICATION':
                    # Simulate user email/phone (in real app, get from user service)
                    user_email = f"user{event['user_id']}@example.com"
                    phone_number = f"+123456789{hash(event['user_id']) % 100}"
                    
                    if event['status'] == 'completed':
                        send_email_notification(
                            user_email,
                            "Payment Successful",
                            f"Your payment for order {event['order_id']} was successful!"
                        )
                        send_sms_notification(
                            phone_number,
                            f"Payment successful for order {event['order_id']}"
                        )
                    else:
                        send_email_notification(
                            user_email,
                            "Payment Failed",
                            f"Your payment for order {event['order_id']} failed. Please try again."
                        )
                
                elif event['event_type'] == 'ORDER_CREATED':
                    user_email = f"user{event['user_id']}@example.com"
                    send_email_notification(
                        user_email,
                        "Order Confirmed",
                        f"Your order {event['order_id']} has been received and is being processed."
                    )
                
                logger.info(f"Processed notification for event: {event['event_type']}")
                
            except Exception as e:
                logger.error(f"Error processing notification: {e}")
                
    except KeyboardInterrupt:
        logger.info("Shutting down notification service...")
    finally:
        consumer.close()

if __name__ == "__main__":
    process_notifications()