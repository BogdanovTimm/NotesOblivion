```cpp
class Class1{
    private:
        int integer1;
        int integer2;
    public:
        Class1(int parameter1 = 100, int parameter2 = 10){ // Constructor
            integer1 = parameter1;
            integer2 = parameter2;
        }
        void function1(int x, int y, int scale, int position);
        int getInteger1(){
            return integer1;
        }
        int getInteger2(){
            return integer2;
        }
};
```

#                  Virtual Functions

```cpp
#include <iostream>

class Parent {
public:
    void function() {// Will be called in all Child classes, even if they override it
        std::cout << "Function from Parent was called";
    }

    virtual void virtualFunction() {
        std::cout << "Virtual Function from Parent was called";
    }
};

class Child : public Parent {
public:
    void function() {
        std::cout << "Function from Child was called";
    }
    void virtualFunction() override {
        std::cout << "Virtual Function from Child was called";
    }
};


int main() {
    Parent child2 = Child();
    child2.function(); // From a Parent
    std::cout << std::endl;
    child2.virtualFunction(); // From a Parent

    std::cout << std::endl;
    std::cout << std::endl;

    Parent* child1 = new Child();
    (*child1).function(); // From a Parent
    std::cout << std::endl;
    (*child1).virtualFunction(); // From a Child
    std::cout << std::endl;
    (* child1).Parent::virtualFunction(); // From a Parent

    std::cout << std::endl;
    std::cout << std::endl;

    Parent* parent1 = new Parent();
    (*parent1).function(); // From a Parent
    std::cout << std::endl;
    (*parent1).virtualFunction(); // From a Parent

    return 0;
}
```

#                  Virtual Classes

If you don't use `class Child1 : public virtual Parent1, public virtual Parent2`, then Child1 will have duplicates of a values of a common variables from both Parent1 and Parent2 if Parent1 and Parent2 are a child of a same class.