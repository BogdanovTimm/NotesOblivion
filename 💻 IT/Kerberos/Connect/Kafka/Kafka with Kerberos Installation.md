1. Set your `/path/to/unpacked/kafka/config/server.properties`
2. Set your `/path/to/unpacked/kafka/config/consumer.properties`
3. Create and set your `/path/to/krb5.conf`
4. Create and set your `/path/to/kafka_server_jaas.conf` - either for using of keytabs or ticket cache
5. Create and set your `/path/to/kafka_client_jaas.conf` - either for using of keytabs or ticket cache
6. Create a **Kerberos_Service** user
7. *[Optinal]* Create a keytab
8. Run your **Zookeeper**:
```shell
/path/to/unpacked/kafka/bin/zookeeper-server-start.sh /path/to/unpacked/kafka/config/zookeeper.properties
```
9. Run your **Kafka_Broker**:
```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_server_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-server-start.sh \
/path/to/unpacked/kafka/config/server.properties \
> kafka.log 2>&1
```
10. Test this setup by creating a new topic:
```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_client_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-topics.sh \
--create --topic newtopic1 \
--bootstrap-server your.broker.com:55552 \
--command-config /path/to/unpacked/kafka/config/consumer.properties \
> kafka_client.log 2>&1
```
11. Test this by displaying created topic:
```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_client_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-topics.sh --list \
--bootstrap-server your.broker.com:55552 \
--command-config /path/to/unpacked/kafka/config/consumer.properties \
> kafka_client.log 2>&1
```
12. Test by creating a Producer:
```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_client_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-console-producer.sh \
--topic newtopic1 \
--bootstrap-server your.broker.com:55552 \
--producer.config /path/to/unpacked/kafka/config/consumer.properties
```
13. Test by creating a consumer:
Consumer:
```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_client_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-console-consumer.sh \
--topic newtopic1 \
--bootstrap-server your.broker.com:55552 \
--consumer.config /path/to/unpacked/kafka/config/consumer.properties
```