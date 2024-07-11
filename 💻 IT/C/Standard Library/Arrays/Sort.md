#                  stdlib.h

- `qsort(array, array_size, element_size, address_of_compare_function)` - the expected number of comparison calls should be of the magnitude of n log2(n), just like quick sort. There are no guarantees for upper bounds; you may assume that its worst-case complexity is at most quadratic, O(n^2*)