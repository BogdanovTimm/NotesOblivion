#                  Installation

1. You need to create **Principal** for every **Kafka_Broker** - Note: I've assumed that the Kafka principal and the associated keytab is already created. If not, you'll need to create these first.
2. Create a `jaas.conf` file with the following contents:
    ```conf
    KafkaServer {
    com.sun.security.auth.module.Krb5LoginModule required
    useKeyTab=true
    # storeKey=true # Only 1 site says it is needed
    keyTab="/etc/security/keytabs/kafka_server_name.keytab"
    principal="kafka/kafka1.hostname.com@REALM.COM";
    };
    ```
3. Create a properties file `consunmer_name.properties` with the following contents on each `Kafka_Broker`:
    ```conf
    security.protocol=SASL_SSL                         # For interbroker communication. Or SASL_PLAINTEXT if you use http://website.com
    sasl.kerberos.service.name=kerberos                # 2 wevsites says there must be 'kafka' instead
    sasl.mechanism=GSSAPI
    # ssl.truststore.location=/path/to/truststore_file # If [security.protocol] = 'SASL_SSL'
    # ssl.truststore.password=password                 # If [security.protocol] = 'SASL_SSL'
    ```
4. `export KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/jaas.conf"`
5. `application_name --topic ^topic_name^ --from-beginning --bootstrap-server ^broker_name^:9092 --consumer.config /path/to/consunmer_name.properties`