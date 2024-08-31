#                  Storing passwords

To store passwords, you need to create a hash of them. Good hashes for passwords are:
- PBKDF2
- bcrypt
- scrypt
- Argon2

##                 Salt

Salt must be always used to hide that 2 users has same password:
1) Generate random string by the langth of the has itself
2) Add this random string to a password
3) Only now compute the hash of the password
4) Now, store both hash of the password and the randomly generated string