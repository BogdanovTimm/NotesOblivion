#                  MTS .PDF

1. Create CA:
    1. Generation of a closed key:
        ```shell
        openssl                  \
        genrsa                   \
        -out    certificate1.key \
        4096
        ```
    2. Create CRT file:
        ```shell
        openssl                  \
        req                      \
        -new                     \
        -x509                    \
        -key    certificate1.key \
        -out    certificate1.crt \
        -days   3650
        ```
2. Create a keystore (it will ask to write a password (123456)):
    ```shell
    keytool                           \
    -keystore server1.keystore.jks    \
    -alias    server1                 \
    -keyalg   RSA                     \
    -validity 3530                    \
    -genkey                           \
    -dname    "CN=server1.domain.ru" \
    -sigalg   SHA256withRSA
    ```
3. Export certificate from a keystore, created in step 3:
    ```shell
    keytool                        \
    -keystore server1.keystore.jks \
    -alias    server1              \
    -certreq                       \
    -file     server1.crt
    ```
4. Sign certificate with the CA created in step 1:
    ```shell
    openssl                            \
    x509                               \
    -req                               \
    -CA             certificate1.crt   \
    -CAkey          certificate1.key   \
    -in             server1.crt        \
    -out            server1-signed.crt \
    -days           3530               \
    -CAcreateserial                    \
    -sha256
    ```
5. Import the certificate of the CA into the server's keystore:
    ```shell
    keytool                        \
    -keystore server1.keystore.jks \
    -alias    CARoot               \
    -import                        \
    -file     certificate1.crt     \
    -noprompt
    ```
6. Import the signed certificate into the server's keystore:
    ```shell
    keytool                        \
    -keystore server1.keystore.jks \
    -alias    server1              \
    -import                        \
    -file     server1-signed.crt
    ```
7. Create truststore for clients:
    ```shell
    keytool                         \
    -keystore client.truststore.jks \
    -alias    client                \
    -import                         \
    -file     certificate1.crt      \
    -noprompt                       \
    -keyalg   RSA                   \
    -sigalg   SHA256withRSA
    ```