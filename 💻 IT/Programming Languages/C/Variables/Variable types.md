#                  Always do

- All block-scope variables should be initialized, thereby eliminating half the problems with uninitialized objects. 


#                  Types of variables

We distinguish four different storage durations:
- `static`    - when it is determined at compile time and its duration is all program execution. If you didn't initialized them, they have been initialized to 0 implicitly.
- `automatic` - when it is automatically determined at runtime - non-`static` variables inside blocks or functions and `register` variables. The lifetime of such an object starts when its scope of definition is entered (you may find its in RAM, although they will be filled with garbage), not, as one would perhaps expect, later, when its definition is first encountered during execution.
- `allocated` - when it is explicitly determined by function calls `malloc()` and friends.
- `thread`    - when it is bound to a certain thread of execution