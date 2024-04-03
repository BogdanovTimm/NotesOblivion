1. Download archive
2. `tar -xzf kafka_2.13-3.7.0.tgz` - Unpack archive
3. You need to choose whether you will use **Zookeeper** or **Kraft**:
    - With **Zookeeper**:
        1. `/path/to/unpacked/kafka/bin/zookeeper-server-start.sh /path/to/unpacked/kafka/config/zookeeper.properties` - run **Zookeeper**
        2. `/path/to/unpacked/kafka/bin/kafka-server-start.sh /path/to/unpacked/kafka/config/server.properties` - run **Kafka_Server**
    - With **Kraft**:
        1. `KAFKA_CLUSTER_ID="$(/path/to/unpacked/kafka/bin/kafka-storage.sh random-uuid)"` - add environment variable
        2. `/path/to/unpacked/kafka/bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c /path/to/unpacked/kafka/config/kraft/server.properties` - do needed manipulations
        3. `/path/to/unpacked/kafka/bin/kafka-server-start.sh /path/to/unpacked/kafka/config/kraft/server.properties`
4. `/path/to/unpacked/kafka/bin/kafka-topics.sh --create --topic newtopicname1 --bootstrap-server localhost:9092` - create a new **Topic** named 'newtopicname1'
5. `/path/to/unpacked/kafka/bin/kafka-topics.sh --list --bootstrap-server localhost:9092` - display all **Topics**
6. `/path/to/unpacked/kafka/bin/kafka-console-producer.sh --topic newtopicname1 --bootstrap-server localhost:9092` - run simple **Kafka_Producer** application
7. `/path/to/unpacked/kafka/bin/kafka-console-consumer.sh --topic newtopicname1 --bootstrap-server localhost:9092` - run simple **Kafka_Consumer** application
8. Done