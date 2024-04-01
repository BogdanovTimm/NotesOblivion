#                  Installation

##                 Kafka itself

1. You need to create **Principal** for every **Kafka_Broker** - Note: I've assumed that the Kafka principal and the associated keytab is already created. If not, you'll need to create these first.
    ```
    sudo /usr/sbin/kadmin.local -q 'addprinc -randkey kafka/host_name@REALM.COM'
    sudo /usr/sbin/kadmin.local -q "ktadd -k /etc/security/keytabs/keytab_name.keytab kafka/host_name@REALM.COM"
    ```
2. Create a `/etc/kafka/jaas.conf` file with the following contents:
    ```conf
    KafkaServer {
    com.sun.security.auth.module.Krb5LoginModule required
    useKeyTab=true
    # storeKey=true # Only 1 site says it is needed
    keyTab="/etc/security/keytabs/kafka_server_name.keytab"
    principal="kafka/kafka1.hostname.com@REALM.COM";
    };
    ```
    Make sure the keytabs configured in the JAAS file are readable by the operating system user who is starting the Kafka broker.
3. Create a properties file `/etc/kafka/server.properties` with the following contents on each `Kafka_Broker`:
    ```conf
    security.protocol=SASL_SSL                                                      # For interbroker communication. Or SASL_PLAINTEXT if you use http://website.com
    sasl.kerberos.service.name=kafka                                                # [name] from [kafka]/kafka1.hostname.com@REALM.COM from jaas.conf
    sasl.mechanism=GSSAPI
    # With TLS/SSL encryption
    listeners=PLAINTEXT://kafka1:9092,SASL_SSL://kafka1:9093                        # Maybe PLAINTEXT is not needed
    advertised.listeners=PLAINTEXT://localhost:9092,SASL_SSL://localhost:9093       # Maybe PLAINTEXT is not needed
    # Without TLS/SSL encryption
    listeners=PLAINTEXT://kafka1:9092,SASL_PLAINTEXT://kafka1:9093                  # Maybe PLAINTEXT is not needed
    advertised.listeners=PLAINTEXT://localhost:9092,SASL_PLAINTEXT://localhost:9093 # Maybe PLAINTEXT is not needed
    # ssl.truststore.location=/path/to/truststore_file                              # If [security.protocol] = 'SASL_SSL'
    # ssl.truststore.password=password                                              # If [security.protocol] = 'SASL_SSL'
    ```
4. `export KAFKA_OPTS="-Djava.security.auth.login.config=/etc/kafka/jaas.conf"`
5. `kafka-start-server.sh --topic ^topic_name^ --from-beginning --bootstrap-server ^broker_name^:9092 --consumer.config /etc/kafka/kafka.properties` OR
    `kafka-start-server.sh etc/kafka/server.properties`

##                 Zookeeper

Maybe it is not needed, just ask