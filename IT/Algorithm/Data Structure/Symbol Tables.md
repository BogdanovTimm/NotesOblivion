If you need a very stable performance (for programming cardio stimulator, for example) - it is better to use `RedBlackTree` (`TreeMap` in Java), because `hachCode()` can be slow for some Object.

So:
- `HashTable` in Java is faster in almost everything
- `TreeMap` is more stable (and sometimes faster) and allows ordered operations
- `TernarySearchTree` - implementation of a Symbol tableas `TST` (Ternary Search Tree) - better one, but it is not implemented in Java

How to determine their speed and which one is better? - I think you just need to see speed in tests