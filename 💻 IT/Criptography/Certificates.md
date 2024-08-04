#                  What it is?

Certificate is a file (usually server's public key), signed by the CA's **???**.









#                  How it works?

1) Browser sends list of algorithms it understands
2) Server sends certificate (**Encrypted-Hash-of-Server's-Public-Key** encrypted by **CA's-Private-Key**)
3) Browser checks that these certificate is not expired and was not revoked:
    1. CA hashes **Server's-Public-Key**
    2. CA encrypts **Hash-of-Server's-Public-Key** using **CA's-Private-Key** (Digital Signature)
    3. Browser retrieves **CA's-Digital-Certificate**
    4. Browser decrypts **Encrypted-Hash-of-Server's-Public-Key** using **CA's-Public-Key** from **CA's-Digital-Certificate**
    5. Browser hashes **Server's-Public-Key**
4) Browser generates a **random_value** (Pre-Master Secret)
5) Browser encrypts this **random_value** with **Server's-Public-Key**
6) Browser sends encrypted **random_value** to server
7) Server decrypt given **random_value**
8) Both Server and Browser generate **Master-Secret** using **random_value**
9) Both Server and Browser generate **Symmetric-Key** using identical **Master-Secret**