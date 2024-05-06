#                  Public and Private

```cpp
void publicFunction() {
    std::cout << "It is a public function";
}

static void privateFunction() {
    std::cout << "It is a private function";
}
```

#                  Parameters

##                 Copy vs Original

```cpp
#include <iostream> // New one

void function(int copyOfGiven, int* addressOfOriginal, int& hardLinkToOriginal {
    copyOfGiven++;
    (*addressOfOriginal)++;
    hardLinkToOriginal++;
}

int main() {
    int integer1 = 1;
    int integer2 = 2;
    int integer3 = 3;
    function(integer1, &(integer2), integer3);
    std::cout << integer1 << std::endl // Not changed
              << integer2 << std::endl // Changed
              << integer3 << std::endl // Changed
    ;
    return 0; // exit code
}
```

##                 `const`

`const` allows you to permit changing of a parameter.

```cpp
void function1(int* ramAddress) {
    std::cout << ramAddress;
    ramAddress++ // No error
}

void function2(const int* ramAddress) {
    std::cout << ramAddress;
    //ramAddress++ // Gives an error
}
```