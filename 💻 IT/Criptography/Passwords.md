#                  Storing passwords

To store passwords, you need to create a hash of them. Good hashes for passwords are (they are good because they are so sliw that brute-firce is not reasonable) :
- PBKDF2
- bcrypt
- scrypt
- Argon2

##                 Salt

Salt must be always used to :
* Hide that 2 users has same password
* Prevent tge use of a lookup-tables (precomputed tables of commonly used passwords without the Salt)

1) Generate random string by the langth of the has itself
2) Add this random string to a password
3) Compute the hash of the password + random string
4) Store both hash of the password and the randomly generated string