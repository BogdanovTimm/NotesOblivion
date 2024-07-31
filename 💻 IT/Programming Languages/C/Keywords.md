#                  Keywords in variables

##                 Do not

- Do not return RAM address area of an `auto` variables from a funcitons. It is nothing wrong with returning a RAM address area of a `static` variable, though.

##                 Keywords

```C
static                int outStatic                                   = 1; // Outside all functions, static = 'private' in Java
static volatile const int outStaticVolatileVariable                   = 1; // static + volatile + readonly
extern                int outVariableFromOtherFile;                        // Use variable, defined somewhere in '#include'. Inherits whether it public or private
extern volatile const int outVariableFromOtherFile;                        // static + volatile + readonly

int main() {
    auto     volatile const int blockAutoVariable                       = 1; // Deafult + volatile + readonly
    register                int blockRegister                           = 1; // Can't be accessed using pointer. Always use this. 
    register volatile const int blockVariableWhichAddressCantBeAccessed = 1; // register + volatile + readonly
    static            const int blockStaticConst                        = 1; // Saves value between function's calls. Faster than auto - initialized only once.
    static   volatile const int blockStaticVariable2                    = 1; // You may return pointer to it
    extern                  int blockExtern;                                 // It is block-static. Inherits whether it public or private
    extern   volatile const int blockVariableFromOutsideOfFunction;
}
```









#                  Functions

##                 Do not

##                 Keywords for functions

```C
extern void function1() { // Default

}

static void function2() { // Here, static = private in Java
    
}
```

##                 Keywords for parameters

```C
void function(char register parameter1) { // Same as register in block-variables

}
```