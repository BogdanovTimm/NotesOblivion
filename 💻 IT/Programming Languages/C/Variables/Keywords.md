#                  Do not

- Do not return RAM address area of an `auto` variables from a funcitons. It is nothing wrong with returning a RAM address area of a `static` variable, though.

```C
static                int outStatic                                   = 1; // Outside all functions, static = 'private' in Java
static volatile const int outStaticVolatileVariable                   = 1;
extern                int outVariableFromOtherFile;                        // Use variable, defined somewhere in '#include'
extern volatile const int outVariableFromOtherFile;

int main() {
    auto     volatile const int blockAutoVariable                       = 1; // Deafult
    register volatile const int blockVariableWhichAddressCantBeAccessed = 1; // Always use this
    static            const int blockStaticConst                        = 1; // Saves value between function's calls. Faster than auto - initialized only once.
    static   volatile const int blockStaticVariable2                    = 1; // You may return pointer to it
    extern                  int blockExtern;                                 // It is block-static
    extern   volatile const int blockVariableFromOutsideOfFunction;
}
```