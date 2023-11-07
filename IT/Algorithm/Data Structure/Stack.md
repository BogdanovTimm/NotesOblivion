# How to pick up

`Stack` has 2 main implementations:

- using `Resizable Array`:
    - generally faster - `O(1)`
    - sometimes very slow - `O(arraySize)`
    - uses ~ `LinkedListSingle` implementation space / 2
- using `LinkedListSingle`:
    - generally slower -
    - uses ~ 2x more space than `ResizableArray` implementation

# Stack using Resizable Array

Memory Space: `amountOfElements`  
Speed:

- `push()`:
    - Generally: `O(1)` (but slower than the `ResizableArray`)
    - Worst: `O(arraySize)`
- `pop()` aka `returnLastAddedAndDeleteIt()`:
    - Generally: `O(1)`
    - Worst: `O(arraySize)` (very rare)

# Stack using LInkedListSingle

Memory Space: `amountOfElements`  
Speed:

- `push()`:
    - Generally: `O(1)` (but slower than the `ResizableArray`)
    - Worst: `O(1)`
- `pop()` aka `returnLastAddedAndDeleteIt()`:
    - Generally: `O(1)`
    - Worst: `O(arraySize)` (very rare)