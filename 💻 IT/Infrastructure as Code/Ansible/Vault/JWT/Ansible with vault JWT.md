1. `vault auth enable jwt`
2. `vault write auth/jwt/config jwks_url="http://vault1.server.ru/-/jwks" bound_issuer="vault1.server.ru"`
3. Create a file for policiy named `folder1.hcl` and add in it:
```
path "test/data/demo_project/repo1" {
  capabilities = [ "read" ]
}
```
4. `vault policy write new_policy1 /path/to/folder1.hcl`
5. Create jwt_role.json file and write in it:
```JSON
{
"role_type": "jwt",
"policies": ["new_policy1"],
"token_explicit_max_ttl": 60,
"user_claim": "user_email",
"bound_claims": {
  "project_id": "302",
  "ref": "main",
  "ref_type": "branch"
  }
}
```
6. `vault write auth/jwt/role/vault-jwt-demo-staging`
7. Create a gitlab-pipeline:
```
job:
  image:
    vault:1.13.3
  script:
    - set -eu
     
    # Проверяем имя ref джобы
    - echo $CI_COMMIT_REF_NAME
 
    # и является ли она protected
    - echo $CI_COMMIT_REF_PROTECTED
 
    # Адрес Vault может быть передан через переменную в CI
    - export VAULT_ADDR=https://vault1.server.ru:8201
 
    # Проходим аутентификацию и получаем токен. Время истечения жизни токена и другие 
    # его параметры можно задать при конфигурации
    # JWT Auth - https://www.vaultproject.io/api/auth/jwt#parameters-1
    - export VAULT_TOKEN="$(vault write -field=token auth/jwt/login role=vault-jwt-demo-staging jwt=$CI_JOB_JWT)"
 
    # Теперь используем VAULT_TOKEN для чтения секретов и сохранения их в перемнных окружения
    - export PASSWORD="$(vault kv get -field=password root_folder/data/folder1)"
 
    # Используем секрет
    - if [[ -z "$PASSWORD" ]]; then exit 1;  else  echo  'Password is '$PASSWORD; fi
```