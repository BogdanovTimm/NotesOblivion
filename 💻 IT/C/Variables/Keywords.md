```C
static volatile const int staticVariable                           = 1;
extern volatile const int variableFromOtherFile;
int main() {
    auto     volatile const int autoVariable                       = 1; // Deafult
    register volatile const int variableWhichAddressCantBeAccessed = 1; // Always use this
    static   volatile const int staticVariable2                    = 1;
    extern   volatile const int variableFromOutsideOfFunction;
}
```