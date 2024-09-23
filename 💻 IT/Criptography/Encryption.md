#                 The Best

* Symmetric: AES 256-bit block size with random Initialization 



#                 Encryption modes

How to deal with padding:
* Symmetric:
    * ECB - don't use it! Encrypts message by blocks of a given size.
    * OFB
    * CTR
    * CBC - Encrypts message by blocks of a given size. Uses eachprevious block to encrypt the next one using XOR. First block is encrypted using IV (Initialization Vector of a size of a block)









#                  Public

Public/Private key pairs allow:
* Authentication - if you encrypt with the private key (since Public-Key that user will descrypt ONLY that message, that was encrypted with its Private-Key)
* Secret communication - if you encrypt with the public key (user1 gives its Public-Key to user2. User2 now may encrypt message, but ONLY user1 can decrypt it)
* Both - if you use 2 pairs of Public/Private keys (user1 encrypts the message using its Public-Key, then using user2's Public-Key)