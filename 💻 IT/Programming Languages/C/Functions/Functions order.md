#                  Functions have order

In C, if you define `main()` function before `functionThatMainUses()`, then your program will not compile. To deal with it, you may just define function's header before `main()` and function's body later (This lonely function's header called prototype).