# What it is all about?

In a given directed, acyclic weighted tree you need to find a subtree that is:

- acyclic
- connects all nodes from original tree
- sum of all bridges between nodes is a minimum of all possible

# Which one is faster?

There is no 1 fast algorithm, you need to choose one of this based on the type of a graph:

- Dijkstra - all weights in a graph must be positive. It is used in map applications. Time: `(amountOfNodes^2 * log(amountOfNodes))`
- Topoligical sort - graph must have no cycles in it. Time: `O(amountOfNodes + amountOfNodes^2)`
- Bellman-Ford - graph may have cycles, but all cycles must be positive. Time: `O(amountOfNodes * amountOfNodes^2)`