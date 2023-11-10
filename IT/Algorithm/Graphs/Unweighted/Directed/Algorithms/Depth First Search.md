# What it is?

This algorithm finds connected Nodes for a given Node or a collection of Nodes.

# Code

```java
public class DirectedDFS {

    private boolean[] marked;

    /**
     * Finds nodes in a given directed forest
     * that are reachable from given node
     */
    public DirectedDFS(Digraph graph, int node) {
        marked = new boolean[graph.V()];
        findConnectedNodes(graph, node);
    }

    /**
     * Find nodes in a given directed forest
     * that are reachable from given collection of nodes
     */
    public DirectedDFS(Digraph graph, Iterable<Integer> sources) {
        marked = new boolean[graph.V()];
        for (int s : sources)
            if (!marked[s])
                findConnectedNodes(graph, s);
    }

    private void findConnectedNodes(Digraph graph, int v) {
        marked[v] = true;
        for (int w : graph.adj(v))
            if (!marked[w])
                findConnectedNodes(graph, w);
    }

    /**
     * Checks whther given node is reachable from node
     * with which it is working on right now
     */
    public boolean marked(int v) {
        return marked[v];
    }
}
```