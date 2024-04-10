#                  What it is

ACL is a way to specify permissions for Kafka users









#                  Commands

##                 Add Rules

###                Allowing Rules

```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_client_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-acls.sh \
--bootstrap-server broker1_name:55552 \
--command-config /path/to/unpacked/kafka/client.properties \
--add --allow-principal User:kafka_username1 \
--operation WRITE \
--topic topic1_name
```

###                Denying Rules

```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_client_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-acls.sh \
--bootstrap-server broker1_name:55552 \
--command-config /path/to/unpacked/kafka/client.properties \
--add --deny-principal User:kafka_username1 \
--operation WRITE \
--topic topic1_name
```

##                 Remove Rules

```shell
KAFKA_OPTS="-Djava.security.auth.login.config=/path/to/kafka_client_jaas.conf \
-Dsun.security.krb5.debug=true \
-Djava.security.krb5.conf=/path/to/krb5.conf" \
/path/to/unpacked/kafka/bin/kafka-acls.sh \
--bootstrap-server broker1_name:55552 \
--command-config /path/to/unpacked/kafka/client.properties \
--remove --deny-principal User:kafka_username1 \
--operation WRITE \
--topic topic1_name
```