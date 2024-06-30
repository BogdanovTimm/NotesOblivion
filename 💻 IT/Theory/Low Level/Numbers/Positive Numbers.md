#                  Addition

For addition (Adder), we use `2^number_of_bits` steps. For example for 3 bits:
1. Half-way add:
    - Inputs:
        - Number1
        - Number2
    - Outputs:
        - Sum   - logical XOR
        - Carry - logical AND
2. Full-add using output from previous step. Where Full-add is:
    - Inputs:
        - Bit1, Bit2, BitForCarry
    - Outputs:
        - Sum
        - Carry
3. Full-add using output from previous step
4. Full-add using output from previous step
5. Full-add using output from previous step
6. Full-add using output from previous step
7. Full-add using output from previous step
8. Full-add using output from previous step