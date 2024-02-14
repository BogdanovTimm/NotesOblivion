# What it is?

This algorithm finds all group of connected nodes.

# Characteristic

Time: **O(amountOfNodes + amountOfBridges)**

# Code

```java
public class ConnectedComponents {
 
    private boolean[] marked;
    private int[] id;
    private int count;

    public ConnectedComponents(UnidrectedGraph graph) {
        marked = new boolean[graph.getAmountOfNodes()];
        id = new int[graph.getAmountOfNodes()];
        for (int s = 0; s < graph.getAmountOfNodes(); s++) {
            if (!marked[s]) {
                findConnectedNodes(graph, s);
                count++;
            }
        }
    }

    private void findConnectedNodes(UnidrectedGraph graph, int v) {
        marked[v] = true;
        id[v] = count;
        for (int w : graph.getArrayOfConections(v)) {
            if (!marked[w]) {
                findConnectedNodes(graph, w);
            }
        }
    }

    public boolean connected(int v, int w) {
        return id[v] == id[w];
    }

    public int id(int v) {
        return id[v];
    }

    public int count() {
        return count;
    }
}
```