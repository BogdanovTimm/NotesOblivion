# What it is?

This algorithm finds shortest path between 2 nodes.

# Characteristics

Time: **O(amountOfNodes + amountOfBridges)**

# Code

```java
public class BreadthFirstSearch {
    private boolean[] marked; // Is a shortest path to this vertex known?
    private int[] edgeTo; // last vertex on known path to this vertex
    private final int s; // source

    public BreadthFirstSearch(UnidrectedGraph G, int s) {
        marked = new boolean[G.getAmountOfNodes()];
        edgeTo = new int[G.getAmountOfNodes()];
        this.s = s;
        bfs(G, s);
    }

    private void bfs(UnidrectedGraph G, int s) {
        SingleLinkedListQueue<Integer> queue = new SingleLinkedListQueue<Integer>();
        marked[s] = true; // Mark the source
        queue.enqueue(s); // and put it on the queue.
        while (!queue.isEmpty()) {
            int v = queue.dequeue(); // Remove next vertex from the queue.
            for (int w : G.getArrayOfConections(v))
                if (!marked[w]) // For every unmarked adjacent vertex,
                {
                    edgeTo[w] = v; // save last edge on a shortest path,
                    marked[w] = true; // mark it because path is known,
                    queue.enqueue(w); // and add it to the queue.
                }
        }
    }

    public boolean hasPathTo(int v) {
        return marked[v];
    }
  
    /**
     * Returns path to given node
     */
    public Iterable<Integer> pathTo(int v) {
        if (!hasPathTo(v))
            return null;
        ResizingArrayStack<Integer> path = new ResizingArrayStack<Integer>();
        for (int x = v; x != s; x = edgeTo[x])
            path.push(x);
        path.push(s);
        return path;
    }
}
```