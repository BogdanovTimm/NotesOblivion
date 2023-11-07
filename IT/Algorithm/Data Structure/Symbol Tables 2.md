There is different Table (Map) realisation:
- Sorted ones: 
    - `LeftLeaningRedBlackBinarySearchTree` (fastest)
    - `BinarySearchTreeLinkedListDouble`
    - 2 arrays + Binary Search - slow to insert values
    - SingleLinkedList + Sequential Search - slow
-  Ones withoit sorting:
    -  `HashTable`:
		-  `Array` of `LinkedListSingle` aka `SeparateChaining` -
		-  `X` aka `LinearProbing`

# Which one to use?

If you need a very stable performance (for programming cardio stimulator, for example) - it is better to use `RedBlackTree` (`TreeMap` in Java), because `hachCode()` can be slow for some Object.

So:
- `TernarySearchTree` aka `TST` - the best one one. There is 2 downsides:
	- it works only with Strings
	- it doesn't implemented in Java
- `HashTable` in Java is faster in almost everything
- `TreeMap` is more stable (and sometimes faster) and allows ordered operations

How to determine their speed and which one is better? - I think you just need to see speed in tests

# 2 arrays + Binary Search

Slow to insert new value (`O(arraySize)`)

array for keys (always sorted)  
array for values

`search()` - binary search `O(log(arraySize))` using `comapreTo()`  
`insert()` - `O(arraySize)`  
`findMin()`, `findMax()` - `O(1)`  
`findTopKthElement()` - `O(1)`

```
  [3] Parent > leftChild, Parent > rightChild
 /   \
[1]  [2]
```

# SingleLinkedList + Sequential Search

Slowest

SingleList - unsorted search using `equal()`

```
  [3] Random order
 /   \
[2]  [1]
```

# BinarySearchTree using DoubleLinkedList

```
  [2] Parent > leftChild, but Parent < rightChild
 /   \
[1]  [3]
```

# Left-leaning Red-Black-Binary-Search Trees

It is a simplier representation of 2-3 Trees

## 2-3 Tree using TripleLinkedList (fastest)

1 or 2 Parents.  
Parent1 < Parent2.

LeftChilds < Parent1.  
MidChild > Parent1 && MidChild < Parent2  
RightChilds > Parent2.

```
       [3, 6]
      /  |   \
[1, 2] [4, 5] [7, 8]
```

## Left-leaning Red-Black-Binary-Search Trees

Speed:
Everything: `O(log(amountOfElements))`

1 or 2 Parents.  
Parent1 < Parent2.

LeftChilds < Parent1.  
MidChild > Parent1 && MidChild < Parent2  
RightChilds > Parent2.

```
                  [4] Parent2 
                 /   \
      Parent1 [2]     [5] Right child
             /   \
Left child [1]     [3] Mid child
```

## HashTable using Array of LinkedListSingle aka SeparateChaining

Speed:
- Generally: `O(1)`
- Worst: `O(lg(amountOfElements))`

Array must be of size = `amountOfElements` / 5

## LinearProbing using 2 arrays

Why Tim is 1st in the array? - because `hash("Tim")` returns `0`. So, Tim's key position = Tim's value position.
```
arrayOfKeysAsHashes
{"Tim", "Anya", "Alex"}

arrayOfValues
{"Tim's password", "Anya's password", "Alex's password"}
```

Array must be of size = `amountOfElements`