e# What it all about?

Every graph have all of this porperties

# (Un)Directed

Bridges between elements may have directions:

```
Undirected:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'


Directed:
    .-------.     .-------.
    | Node1 |---->| Node2 |
    `-------'     `-------'
```

# (Dis)Connected

Whether all nodes are somehow connected or not (whether there is 1 graph or more)

```
Connected:
    .-------.     .-------.     .-------.
    | Node1 |-----| Node2 |-----| Node3 |
    `-------'     `-------'     `-------'

Disconnected:
    .-------.     .-------.     .-------.
    | Node1 |-----| Node2 |     | Node3 |
    `-------'     `-------'     `-------'
```

# (A)Cyclic

Whether there is a cycle in a graph

```
Cyclic:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \     /
           .-------.
           | Node3 |
           `-------'

Acyclic:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \
           .-------.
           | Node3 |
           `-------'
```

# (Un)Regular

Whether all nodes has same amount of connected nodes:

```
Regular (Every node has 2 connected nodes):
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \     /
           .-------.
           | Node3 |
           `-------'

Unregular (Node1 has 2 connected nodes. Node2 and Node3 have only 1 connected node):
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \
           .-------.
           | Node3 |
           `-------'
```

# (Un)Weighted

# (In)Finite

Whether we know final amount of nodes in a graph

# (Un)Complete

Whether every node are connected to each other

```
Complete:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \     /
           .-------.
           | Node3 |
           `-------'

Uncomplete:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \
           .-------.
           | Node3 |
           `-------'
```

# (Non-)Pseudo

Whether there is self-loops:

```
Pseudo:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
      |  |
       `-'

Non-Pseudo:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
```

# Simple/Multi

Whether there is only 1 path between 2 nodes or more AND whether there is a self-loops or not:

```
Simple:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'

Multi:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            `-----'

Multi 2:
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
      |  |
       `-'
```

# Special cases that has names

## Bipartite

For a graph to be a Bipartite graph, it needs to satisfy some of the basic preconditions. These conditions are:

- All nodes of the graph should be divided into group1 and group2.
- All nodes in group1 should only be connected to nodes present in group2.
- Both groups should not contain the same nodes in them.

```
Group1: Node1, Node2
Group2: Node3, Node4
    .-------.    .-------.
    | Node1 |----| Node3 |
    `-------'\   `-------'
              \
               \ 
    .-------.   \.-------.
    | Node2 |----| Node4 |
    `-------'    `-------'
```

## Euler

All nodes have an even amount of connected nodes

```
Euler (each node has even (2 in this case) amount of connected nodes):
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \     /
           .-------.
           | Node3 |
           `-------'

Non-Euler (Node2 and Node3 have an odd (1 in this case) amount of connected nodes):
    .-------.     .-------.
    | Node1 |-----| Node2 |
    `-------'     `-------'
            \
           .-------.
           | Node3 |
           `-------'
```

# Planar

Graph can be drawn without intersected connections:

```
Planar (No intersected connections):
    .-------.    .-------.
    | Node1 |----| Node3 |
    `-------'   /`-------'
        |      /     |
        |     /      |
    .-------./   .-------.
    | Node2 |----| Node4 |
    `-------'    `-------'

Non-Planar (there are intersected connections):
    .-------.    .-------.
    | Node1 |----| Node3 |
    `-------'\  /`-------'
        |     \/     |
        |     /\     |
    .-------./  \.-------.
    | Node2 |----| Node4 |
    `-------'    `-------'
```