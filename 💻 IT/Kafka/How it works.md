#                  What it is

Kafka is something like a SQL Database that works via APIs









#                  Structure

Representation of a machines:
- **Kafka_Broker** - Kafka itself
- **Producer_Application** - every application that uses API to load data into Kafka
- **Consumer_Application** - every application that uses API to get data from Kafka

```
Producer_Application ---> Kafka_Broker ---> Consumer_Application
```

Representation of the data:
- **Topic** - group of similar data
- **Partition** - part of the **Topic** (each **Partition** may be on different **Kafka_Broker**)
- **Segment** - group of files that represents 1 **Partition**