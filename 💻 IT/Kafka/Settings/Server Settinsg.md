#                  Path

`/path/to/unpacked/kafka/config/server.properties`









#                  Settings

## Must be set for an out-of-a-box running:

- `zookeeper.connect=your.server.ru:55551` - hostname and port of a Zookeeper Server
- `broker.id=228` - id of a **Kafka_Broker**. Must be unique for every **Kafka_Broker**






##                 Pro settings

###                Kerberos

- `sasl.enabled.mechanisms=GSSAPI` - for **Kerberos** to work
- `sasl.mechanism.inter.broker.protocol=GSSAPI` - to enable encryption between interconnection communication between all **Kafka_Broker**s
- `listeners=SASL_PLAINTEXT://this.server.com:55552` - [TYPE_OF_ENCRYPTION]://[this.pc.name]:[port] - ports on this PC that will listen. Default is `PLAINTEXT://localhost:9092`
- `advertised.listeners=SASL_PLAINTEXT://this.server.com:55552` - Ports on this PC that will open to handle requests. Must be a subset of `listeners`
- `sasl.kerberos.service.name=kafka` - [kafka] from kafka/server.broker.com@KERBEROS.REALM
- `security.inter.broker.protocol=SASL_PLAINTEXT` - I don't know
- `# inter.broker.listener.name=SASL_PLAINTEXT` - optional