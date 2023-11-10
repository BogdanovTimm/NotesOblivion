# What it is?

This algorithm finds all group of connected nodes in which every Node1 is connected with every Node2 AND Node2 is connected with Node1.

The fastest is a Kosaraju's one.

# Code

```java
public class KosarajuSCC {

    private boolean[] marked; // reached vertices
    private int[] id; // component identifiers
    private int count; // number of strong components

    public KosarajuSCC(Digraph graph) {
        marked = new boolean[graph.V()];
        id = new int[graph.V()];
        DepthFirstOrder order = new DepthFirstOrder(graph.reverse());
        for (int s : order.reversePost()) {
            if (!marked[s]) {
                findConnectedNodes(graph, s);
                count++;
            }
        }
    }

    private void findConnectedNodes(Digraph graph, int v) {
        marked[v] = true;
        id[v] = count;
        for (int w : graph.adj(v)) {
            if (!marked[w]) {
                findConnectedNodes(graph, w);
            }
        }
    }

    public boolean stronglyConnected(int v, int w) {
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