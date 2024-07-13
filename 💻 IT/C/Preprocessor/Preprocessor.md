In preprocessor conditions, unknown identifiers evaluate to 0. 

#                  Macro-functions

From:
```C
someType* someType_new(long long numesomeTypeor , unsigned long long denominator) {
    return someType_init(malloc(sizeof(someType)), numesomeTypeor,  denominator);
}
int main() {
    someType const* mysomeType = someType_new (13, 7);
}
```
To:
```C
#define NEW_MACRO(GIVEN_TYPE, ...) GIVEN_TYPE ## _init(malloc(sizeof(GIVEN_TYPE)), __VA_ARGS__)// Here T will be replaced by given.
                                                                                               // 'T ## _init' means that they will be concatenated
                                                                                               // '...' may be used as '__VA_ARGS__'
int main() {
    //              Code below = 'someType_init(someType, 13, 8)'
    someType const* mysomeType = NEW_MACRO(someType, 13, 7);
}
```