#                  Path

`/path/to/unpacked/kafka/config/consumer.properties`









#                  Settings

##                 Must be set for an out-of-a-box running:

- `group.id=test-consumer-group`









##                 Pro settings

###                Kerberos

- `bootstrap.servers=broker.ru:55552` - **Kafka_Broker** address and port
- `sasl.mechanism=GSSAPI` - for **Kerberos** to work
- `security.protocol=SASL_PLAINTEXT` - Configure 'SASL_SSL' if TLS/SSL (https) encryption is enabled, otherwise configure 'SASL_PLAINTEXT'
- `sasl.kerberos.service.name=kafka` - [kafka] from kafka/server.broker.com@KERBEROS.REALM

###                SSL

- `security.protocol=SASL_SSL`
- `sasl.kerberos.service.name=kafka`
- `ssl.truststore.location=/path/to/client.truststore.jks`
- `ssl.truststore.password=password_for_client.truststore.jks`