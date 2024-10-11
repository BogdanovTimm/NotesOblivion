Integrity - Authentication

Shipher text - cryptogram
Shipher:
- Symmetrical - uses one secret key for both shipher and deshipher (or second key maybe generated easilly) - fast, but you need to often change key somehow:
    - Block - shiphers by chunks
    - Stream - shiphers by symbols
- Assymetrical - uses open key for shipher and secret key for deshipher. Slower, but you may transport keys via unsafe path

- EDE aka Encrypt-Decrypt-Encrypt - combined shipher:
    1. Encrypt using key1
    2. Decrypt using key2
    3. Encrypt using key1 again or using key3

Diffy-Hellman metho of transporting keys:
- Human1 creates his own private_key1 and public_key1
- Human2 creates his own and private_key2, public_key2
- Using publi_key1 and public_key2, it creates new private_key3