1. Generation of a closed key (don't show it to anybody!):
    ```shell
    openssl                    \
        genrsa                 \
        -out   closed_key1.key \
        2048
    ```
2. Create a CSR:
    ```shell
    openssl                  \
        req                  \
        -new                 \
        -key closed_key1.key \
        -out test1.csr
    ``` 
3. Create CRT file:
    ```shell
    openssl                           \
        x509                          \
        -req                          \
        -days    365                  \
        -in      test1.csr            \
        -signkey closed_key1.key      \
        -out     new_certificate1.crt
    ```