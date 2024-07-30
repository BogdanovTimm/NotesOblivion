#                  What it is

It is a pointer to a funciton









#                  Code

```C
#include <stdio.h>

void functionThatTakesFunctions(void givenFunction(char , int ),
                                char argumentForGivenFunction1,
                                int  argumentForGivenFunction2
) {
    givenFunction(argumentForGivenFunction1,
                  argumentForGivenFunction2
    );
}

void function1(char givenChar, int givenInt) {
    printf("Given: [%c] and [%d]\n", givenChar, givenInt);
}

int main(void) {
    void (* functionAsVariable)(char, int) = function1;
    functionThatTakesFunctions(functionAsVariable, 'a', 5);
    
    functionThatTakesFunctions(function1, 'a', 5); // Same as previous call
}
```