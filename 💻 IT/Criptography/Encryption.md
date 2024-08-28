#                 The Best

* Symmetric: AES 256-bit block size with random Initialization 



#                 Encryption modes

How to deal with padding:
* Symmetric:
    * ECB - don't use it! Encrypts message by blocks of a given size.
    * OFB
    * CTR
    * CBC - Encrypts message by blocks of a given size. Uses eachprevious block to encrypt the next one using XOR. First block is encrypted using IV (Initialization Vector of a size of a block)