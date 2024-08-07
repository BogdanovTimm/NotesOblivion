#                  DONOT

- Use signed numbers for working with bits









#                  Representation

`{4, 5}` means:
```
76543210
--------
00110000
```







# And, or, xor

- Anding with 0s allow you to set bits to 0s:
    ```
    011011010 AND
    110000111 will be
    ---------
    010000010
    ```
- Oring with 1s allow you to set bits to 1s:
    ```
    011011010 OR
    001111000 will be
    ---------
    011111010
    ```
- Xoring with 1s allow you to flip 1s to 0s and 0s to 1s:
    ```
    011011010 XOR
    001111000 will be
    ---------
    010100010
    ```

#                  << and >>

`X << 3` is same as `X * 2^3`
```
00011 << 2
=
01100
```
If new bits will not fit into number of allowed bits - they will simply be dropped

`X << 3` is same as `X / 2^3`
```
01100 >> 2 
=
00011
```









#                  ~

Simply chooses each bit to other value:
```
 A 101100
~A 010011
```









#                  Operations with bits

- Set  to 1:
    - `variable |= 1 << positionFromRight` - set 1 bit to 1 at a given position. Do not alter others. If already 1 - do nothing.
    - `variable |=  0x0010` - set given 1s to 1s. Do not alter others. If already 1 - do nothing.
    - `variable |=  0x0010 | 0x0001` - set given 1s to 1s. Do not alter others. If already 1 - do nothing.
- Set  to 0:
    - `variable &= ~(1 << positionFromRight)` - set 1 bit to 0. Do not alter others. If already 0 - do nothing.
    - `variable &= ~(0x0010)` - set given 1s to 0s. Do not alter others. If already 0 - do nothing.
    - `variable &= ~(0x0010 | 0x0001)` - set given 1s to 0s. Do not alter others. If already 0 - do nothing.
- Set to 1s and 0s:
    - `variable = variable & ~0x0070 | 0x0050` - clear bits 4-6 and then set new ones
- Get 1s and 0s:
    - `values = (variable >> 4) & 0x0007` - gets 4-6 bits
- Test if 1:
    - `if (variable & 1 << positionFromRight)` - check if given 1 is 1.
    - `if (variable & 0x0010)` - check if given 1s is 1s.
    - `if (variable & (0x0010 | 0x0001))` - check if either given bit is 1










#                  Cool stuff


- `A \ B` = `A - (A&B)` 
- `V + 1` = `0`, where `V = 11111111`
- `A ^ B` = `(A - (A&B)) + (B - (A&B))`
- `A ^ B` = `A + B - 2*(A&B)`
- `A | B` = `A + B - (A&B)`
- `~B` = `V - B`
- `~B` = `V - B`
- `-B` = `~B + 1`
- Only in unsigned: `A + ~A` = `−1`
- Only in unsigned: `A + (~A + 1)` = `0`









#                  Working with bits

You can work with bits, using them within an unsigned int:

```C
enum corvid { 0 = magpie , 1 = raven , 2 = jay , 3 = chough , 4 = corvid_num , }; 
#define FLOCK_MAGPIE (1U << magpie)         // 0000000000000000000000000000001
#define FLOCK_RAVEN  (1U << raven)          // 0000000000000000000000000000010
#define FLOCK_JAY    (1U << jay)            // 0000000000000000000000000000100
#define FLOCK_CHOUGH (1U << chough)         // 0000000000000000000000000001000
#define FLOCK_EMPTY  0U                     // 0000000000000000000000000000000
#define FLOCK_FULL   ((1U << corvid_num)-1) // 0000000000000000000000000000111

int main(void) {
    unsigned flock = FLOCK_EMPTY; // flock = ...00000000
    if (something) {
        flock |= FLOCK_JAY;       // flock = ...00000100
    }
    if (flock & FLOCK_CHOUGH) {// if flock = ...????1???
        do_something_chough_specific(flock);
    }
```