#                  What it is

Lines of code that can be accessed only via `xNAMESPACEx::xVARIABLEx`. It is used to create interfaces:
```cpp
namespace xNAMESPACEx {
    int xVARIABLEx = 1;
    void xINTERFACE_FUNCTIONx(int parameter1, int parameter2);
    void xFUNCTIONx() {
        std::cout << "Lorem Ipsum";
    }
}

std::cout << xNAMESPACEx::xVARIABLE1x;
using xNAMESPACEx::xVARIABLEx;
std::cout << xVARIABLE1x;
using namespace xNAMESPACEx;
std::cout << xVARIABLE1x;
```