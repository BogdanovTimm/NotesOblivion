#                  How does it works?

VM machine controls stacks which is simply an abstraction. On assembly level, there is no stack.
VM also may call functions built-in in the OS.

Stack is just some number of Registers in the RAM:
- 0  Register - keeps pointer to a next Register in which stack will store value
- XX Register - keeps values stored in the stack









#                  Where does stack stores values?

Stack stores data in the different numbers of RAM:
- Register  to store pointer to a next Register in which stack will store value
- Registers to store stack's values
- Registers to store static variables and 1 Register to store 1st address of Registers that store statis cariables
- Registers to store arguments of current function and 1 Register to store 1st address of Registers that store arguments of current function









#                  How it will be in C

- Local variables:
    - `push local 2`:
    ```cpp
    ram_address_we_work_with = LOCAL_RAM_ADDRESS + 2;
    (* current_stack_pointer) = (* ram_address_we_work_with);
    current_stack_pointer++;
    ```
    - `pop local 2`:
    ```cpp
    ram_address_we_work_with = LOCAL_RAM_ADDRESS + 2;
    current_stack_pointer--; // Because current_stack_pointer always point to the next empty RAM Register, we need to go back to find last stored value
    (* ram_address_we_work_with) = (* current_stack_pointer);
    ```
- Arguments of current function:
    - `push argument 2`:
    ```cpp
    ram_address_we_work_with = LOCAL_RAM_ADDRESS + 2;
    (* current_stack_pointer) = (* ram_address_we_work_with);
    current_stack_pointer++;
    ```
    - `pop argument 2`:
    ```cpp
    ram_address_we_work_with = LOCAL_RAM_ADDRESS + 2;
    current_stack_pointer--; // Because current_stack_pointer always point to the next empty RAM Register, we need to go back to find last stored value
    (* ram_address_we_work_with) = (* current_stack_pointer);
    ```
- this argument:
    - `push this 2`:
    ```cpp
    ram_address_we_work_with = LOCAL_RAM_ADDRESS + 2;
    (* current_stack_pointer) = (* ram_address_we_work_with);
    current_stack_pointer++;
    ```
    - `pop this 2`:
    ```cpp
    ram_address_we_work_with = LOCAL_RAM_ADDRESS + 2;
    current_stack_pointer--; // Because current_stack_pointer always point to the next empty RAM Register, we need to go back to find last stored value
    (* ram_address_we_work_with) = (* current_stack_pointer);
    ```
- Constant variables:
    - `push const 2`:
    ```cpp
    (* current_stack_pointer) = 2;
    current_stack_pointer++;
    ```









#                  How function call works?

1. Stack pushes in itlsef arguments for a function that it wants to call
2. Stack saves pointer to 2st arguments for a new function
3. Stack saves pointers to the addresses in RAM of its:
    - 1st local variable
    - 1st argument for itself
    - this
    - that
4. Initializes number local arguments for a new function
5. Do what funciton requires
6. Finds 1st localvariable (that also the 1st Register in Stack for this function call)
7. Finds and sets previously saved pointers to the addresses in RAM for:
    - Previous function's 1st local variable
    - Previous function's 1st argument for itself
    - Previous function's this
    - Previous function's that
8. Goto where previous function has stopped (it is 1st local variable register address - number of saved pointers for previous funciton)