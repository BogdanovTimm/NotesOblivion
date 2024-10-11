# How to send encrypted message

```C
int    ReceiverPublicKey  = open("/home/username/keys/receiverpublickey.key");
int    MyPrivateKey       = open("/home/username/keys/MyPrivateKey.key");
int    RandomSymmetricKey = random();
char[] Text               = "Lorem Ipsum";

// v--- Creation of the {"Hash, ecnrypted by my Private-Key" + "Original Text"}
int[]  HashOfText                         = hash(Text);
char[] HashEncryptedByMyPrivateKey        = encryption(HashOfText, MyPrivateKey);
char[] HashEncryptedByMyPrivateKeyAndText = HashEncryptedByMyPrivateKey + Text;
// ^--- Creation of the {"Hash, ecnrypted by my Private-Key" + "Original Text"}

// v--- Creation of the {"Hash, encrypted by my Private-Key + Original Text, Both encrypted by Random Symmetric Key" + "Symmetric Key, encrypted by Receiver Public Key"}
char[] HashEncryptedByMyPrivateKeyAndTextBothEncryptedByRandomSymmetricKey = encryption(EncryptedHashOfTextAndText, RandomSymmetricKey);
char[] SymmetricKeyEncryptedByReceiverPublicKey = encryption(RandomSymmetricKey        , ReceiverPublicKey);
char[] MessageToSend = HashEncryptedByMyPrivateKeyAndTextBothEncryptedByRandomSymmetricKey + SymmetricKeyEncryptedByReceiverPublicKey;
// ^--- Creation of the {"Hash, encrypted by my Private-Key + Original Text, Both encrypted by Random Symmetric Key" + "Symmetric Key, encrypted by Receiver Public Key"}
```