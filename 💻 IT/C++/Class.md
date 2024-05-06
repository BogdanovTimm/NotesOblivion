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