# What it is?

This data structure represents Undirected Weighted Edge (Connection) that is used in Edge Weighted Graph.

# Code

```java
public class Edge implements Comparable<Edge> {

    private final int node1; // one vertex
    private final int node2; // the other vertex
    private final double weight; // edge weight

    public Edge(int node1, int node2, double weight) {
        this.node1 = node1;
        this.node2 = node2;
        this.weight = weight;
    }

    public double weight() {
        return weight;
    }
  
    public int either() {
        return node1;
    }
  
    public int other(int node) {
        if (node == node1) {
            return node2;
        }
        else if (node == node2) {
            return node1;
        }
        else {
            throw new RuntimeException("Inconsistent edge");
        }
    }
  
    public int compareTo(Edge otherEdge) {
        if (this.weight() < otherEdge.weight()) {
            return -1;
        }
        else if (this.weight() > otherEdge.weight()) {
            return +1;
        }
        else {
            return 0;
        }
    }
  
    public String toString() {
        return String.format("%d-%d %.2f", node1, node2, weight);
    }
}
```