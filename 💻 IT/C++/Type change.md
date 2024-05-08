# Types of type changing

- `const_cast<givenClass>(givenPointer)`
- `dynamic_cast<givenClass>(givenPointer)`
- `static_cast<givenClass>(givenPointer)` - changing without restrictions. Very dangerous.
- `reinterpret_cast<givenClass>(givenPointer)` - changing without restriction. even more dangerous

Check class:
```cpp
int integer = 1;
if (typeid(integer) == typeid(int)) {
    std::cout << "Given variable is integer!";
}
```

## const_cast

```cpp
#include <iostream>

void function(int* integerPointer) {
    std::cout << (* integerPointer) << std::endl;
    (* integerPointer) = 9;
}

int main() {
    const int* constantIntegerPointer = new int(1);
    std::cout << (* constantIntegerPointer) << std::endl;
    // (* constantIntegerPointer) = 9;   // Error
    // function(constantIntegerPointer); // Error
    int* integerPointer = const_cast<int*>(constantIntegerPointer);
    (* integerPointer) = 2;
    std::cout << (* integerPointer) << std::endl;
    function(integerPointer);
    std::cout << (* integerPointer);
    return 0;
}
```

## dynamic_cast

You can cast Parent to a Child, Child to a Parent, Child to a Child, if they have same Parent.

```cpp
#include <iostream>

class Parent {
public:
    int integer;
};

class Child : public Parent {
public:
    double double1;
};

int main() {
    Child* child = new Child();
    std::cout << (*child).double1 << std::endl;
    Parent* parent = dynamic_cast<Parent*>(child);
    // std::cout << (*parent).double1 << std::endl; // Error
    return 0;
}
```

##                 static_cast

```cpp

```