#                  Combinatorial vs Sequential Logic

* Combinatorial Logic - everything works instanteniously
* Sequential Logic - current input will be worked on only on next iterator of internal clock















#                  Hardware for Sequential Logic

* Bit-chep that keeps some information forever depending on input:
    * Inputs:
        * Data
        * Whether to store given in this time data in next iterations of internal clock
    * Output:
        * Data

Bit-cheap consist of:
    - Mux
    - DFF-cheap that keeps some information only in next iteration (after this, data will be lost)