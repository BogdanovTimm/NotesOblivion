# Primitives

boolean - 1 byte
byte - 1 byte
char - 2 bytes
int - 4 bytes
float - 4 bytes
long - 8 bytes
double - 8 bytes

# Reference to Object

Reference to object - 8 byte

# Inner Classes

Non-static nested class - 8 bytes

# Objects

Consists of parts:
- Metadata - 16 bytes
- Sum of bytes for each primitive variables, references and inner classes
- If all parts above doesn't divide to 8 without reminder - add that reminder

# Collections

## Array

Array itself = 24 bytea

### Array of primitives

`Array itself` + (`primitiveMemory` * `amountOfPrimitives`) + Reminder of division of previous to 8

### Array of objects

(`Array itself`) + (`reference` * `<GivenGenericClass>`  * `amountOfPrimitives`) + Reminder of division of previous to 8

### Array of arrays

8 * `amountOfInnerArrays` * `amountOfObjectInInnerArray`

## SingleLinkedList

Where LinkedList itself = 32 bytes

Node = 40 bytes

(`LinkedList itself` + `Node`) * (`<GivenGenericClass>` * `AmountOfElements`) + Reminder of division of previous to 8