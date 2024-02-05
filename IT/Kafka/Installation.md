1. `docker run --rm confluentinc/cp-kafka:7.5.0 kafka-storage random-uuid` - generating random Id for claster
2. Create docker-compose.yaml file, for example:
```YAML
version: "3"

volumes:
    kafka:

services:
    kafka:
        # Create new image, instsead of using a pre-defined one --v
        build:
            context: .
            dockerfile: kafka.dockerfile
        # File with environment variables for kafka --v
        env_file:
            - kafka.env
        ports:
            - 127.0.0.1:9092:29092/tcp
        # Synchronization with folder on PC that runs docker --v
        volumes:
            - kafka:/var/lib/kafka/data:rw
    
    
    
    
    
    kafka_ui:
        image: provectuslabs/kafka-ui:latest
        environment:
            KAFKA_CLUSTERS_0_NAME: local
            KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS: kafka:29092
            KAFKA_CLUSTERS_0_METRICS_PORT: 9999
            KAFKA_CLUSTERS_0_METRICS_TYPE: JMX
        ports:
            - 127.0.0.1:8080:8080/tcp
        depends_on:
            kafka:
                # Runs kafka_ui only when 
                condition: service_healthy
    
    
    
    
    # CLI client for Kafka
    kcat:
        image: edenhill/kcat:1.7.1
        entrypoint: ["sh", "-c", "while true; do sleep 1d; done"]
        depends_on:
            kafka:
                condition: service_healthy
```
3. Create kafka.env - file with environment variables for kafka:
```
CLUSTER_ID=
KAFKA_NODE_ID=1
KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092
KAFKA_PROCESS_ROLES=broker,controller
KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
KAFKA_CONTROLLER_QUORUM_VOTERS=1@kafka:29093
KAFKA_LISTENERS=PLAINTEXT://kafka:29092,CONTROLLER://kafka:29093,PLAINTEXT_HOST://0.0.0.0:9092
KAFKA_INTER_BROKER_LISTENER_NAME=PLAINTEXT
KAFKA_CONTROLLER_LISTENER_NAMES=CONTROLLER
KAFKA_JMX_PORT=9999
KAFKA_JMX_HOSTNAME=kafka
```
4. Create dkafka-healthcheck.sh:
```BASH
#!/bin/sh
exec /usr/bin/kafka-broker-api-versions --bootstrap-server localhost:9092 2>/dev/null
```
5. Create kafka.dockerfile:
```Dockerfile
FROM confluentinc/cp-kafka:7.5.0
USER root
COPY ./kafka-healthcheck.sh /usr/local/bin/
RUN \
    chmod 0755 /usr/local/bin/kafka-healthcheck.sh
USER appuser
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "/usr/local/bin/kafka-healthcheck.sh" ]
```
6. `docker-compose up` - run docker-compose.yaml file
7. `docker-compose exec kcat sh` - open kcat