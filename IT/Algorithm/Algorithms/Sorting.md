# How to pick up sorting algorithm in general:

## Arrays

1.  Use  `3-way Quick Sort`
2.  If you need to sort duplicate elements - use `3-way Quick Sort`
3.  If you need stable sort (sorts that preserves sorting of other sorts) and don't think about memory - use `Merge Sort`
4.  If you need Sort that always would be equally fast - use `Merge Sort` (Quick Sort has a very-very-very tiny chance to work with `O(N^2)`)
5.  If you need to sort partially-sorted arrays - use `Insertion Sort`

Affordable mention:

- `Heap Sort` - it is equally fast to Quick Sort, but rarely used because it works bad with cashing (now every processor uses cashinig)

# 3WayQuickSort

Memory Space: `0`
Speed:
- Generally: `O(arraySize * log(arraySize))` (but actually it is faster)
- Worst: `O(arraySize^2)` (but it is very small chance that it will occur)
Stable (does it preserves previous sorts?) - No

# Merge Sort

Memory Space: `amountOfElements`
Speed:
- Generally: `O(arraySize * log(arraySize))`
- Worst: `O(arraySize * log(arraySize))`
Stable (does it preserves previous sorts?) - Yes