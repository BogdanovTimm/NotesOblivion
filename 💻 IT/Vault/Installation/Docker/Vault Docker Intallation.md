Приведу вырезку из docker-compose.yml файла, который вы можете использовать, чтобы попробовать это хранилище в действии. Это не dev-режим, где данные хранятся в памяти, а вполне себе production, где данные хранятся постоянно.
```
vault:
  build: ./docker/vault
  container_name: my_vault
  command: server
    -config=/vault/config/vault-config.json
  cap_add:
    - IPC_LOCK
  env_file:
    - ./.env
  #depends_on:
  #  - prometheus
  ports:
    - ${VAULT_PORT}:8200
  volumes:
    - ./data/vault:/vault/file
    - ./logs/vault:/vault/logs
  networks:
    - ${NETWORK_NAME}
```
В данном варианте у меня vault работает в связке с Prometheus’ом, куда пишутся метрики.

Файлы логов и хранилище лежат не во внутреннем volume, а в каталоге на хосте.

Переменные ${VAULT_PORT} и ${NETWORK_NAME} задаются в .env файле и выглядят так:
```
VAULT_PORT=8200
VAULT_ADDR=http://127.0.0.1:8200
NETWORK_NAME=project_web
```

Dockerfile, который лежит в каталоге ./docker/vault выглядит так:

```
ROM vault:1.3.1
LABEL Component="vault-server"

COPY vault-config.json /vault/config/vault-config.json
ENTRYPOINT ["vault"]

EXPOSE ${VAULT_PORT}
```

Содержимое конфига vault-config.json:
```
{
  "storage": {
    "file": {
      "path": "/vault/file"
    }
  },
  "listener": {
    "tcp":{
      "address": "0.0.0.0:8200",
      "tls_disable": 1
    }
  },
  "telemetry": {
    "prometheus": {
      "prometheus_retention_time": "30s",
      "disable_hostname": true
    }
  },
  "ui": true
}
```

После запуска docker-compose up -d, хранилище должно заработать. Но пользоваться им ещё нельзя. 🙂

Инициализируем оператора:

`sudo docker exec -it my_vault /bin/sh -c "vault operator init"`

Команда отработает и выдаст результат:

Unseal Key 1: ключ 1
Unseal Key 2: ключ 2
Unseal Key 3: ключ 3
Unseal Key 4: ключ 4
Unseal Key 5: ключ 5

Initial Root Token: рутовый токен
Значения ключей я вырезал, у вас они будут свои.

Далее выполняем следующие команды, подставляя значения ключей, выданных предыдущей командой:
```
docker exec -it my_vault /bin/sh -c "vault operator unseal <unseal key 1>"
docker exec -it my_vault /bin/sh -c "vault operator unseal <unseal key 2>"
docker exec -it my_vault /bin/sh -c "vault operator unseal <unseal key 3>"
```

Логинимся под root’ом, указав вместо <root token> значение рутового токена, выданого командой operator init:

docker exec -it my_vault /bin/sh -c "vault login <root token>"
Активируем KV движок:

docker exec -it my_vault /bin/sh -c "vault secrets enable -version=1 -path=secret kv"
Теперь мы можем писать:

vault kv put secret/foo bar=baz
и читать данные из secret:

vault kv get --format=json secret/foo
Хранилище готово к работе, теперь можно обращаться к нему по http и получать или сохранять секретные данные.