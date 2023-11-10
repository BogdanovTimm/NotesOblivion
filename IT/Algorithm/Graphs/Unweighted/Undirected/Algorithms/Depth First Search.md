# What it is?

This algorithm finds all nodes, that are connected to a given node.

# Code

```java
public class DepthFirstSearch {

    private boolean[] marked; // Has dfs() been called for this vertex?
    /**
     * From which node we came to some node
     */
    private int[] arrayOfAllNodesConnectedToGiven;
    private final int nodeToFindConnectionsTo;

    public DepthFirstSearch(UnidrectedGraph graph, int nodeToFindConnectionsTo) {
        marked = new boolean[graph.getAmountOfNodes()];
        arrayOfAllNodesConnectedToGiven = new int[graph.getAmountOfNodes()];
        this.nodeToFindConnectionsTo = nodeToFindConnectionsTo;
        findConnectedNodes(graph, nodeToFindConnectionsTo);
    }

    private void findConnectedNodes(UnidrectedGraph graph, int nodeToFindConnectionsTo) {
        marked[nodeToFindConnectionsTo] = true;
        for (int w : graph.getArrayOfConections(nodeToFindConnectionsTo)) {
            if (!marked[w]) {
                arrayOfAllNodesConnectedToGiven[w] = nodeToFindConnectionsTo;
                findConnectedNodes(graph, w);
            }
        }
    }

    public boolean isMainNodeConnectedWithGiven(int node) {
        return marked[node];
    }

    /**
     * Returns path to given node
     */
    public Iterable<Integer> pathToGivenFromMainNode(int node) {
        if (!isMainNodeConnectedWithGiven(node)) {
            return null;
        }
        ResizingArrayStack<Integer> path = new ResizingArrayStack<Integer>();
        for (int x = node; x != nodeToFindConnectionsTo; x = arrayOfAllNodesConnectedToGiven[x]) {
            path.push(x);
        }
        path.push(nodeToFindConnectionsTo);
        return path;
    }
}
```