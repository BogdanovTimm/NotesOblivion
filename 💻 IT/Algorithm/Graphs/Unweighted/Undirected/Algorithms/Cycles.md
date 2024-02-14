# What it is?

This algorithm checks whether some graph has cycles in it.

# Code

```java
public class Cycle {

    private boolean[] marked;
    private boolean hasCycle;

    public Cycle(UnidrectedGraph graph) {
        marked = new boolean[graph.getAmountOfNodes()];
        for (int s = 0; s < graph.getAmountOfNodes(); s++)
            if (!marked[s])
                dfs(graph, s, s);
    }

    private void dfs(UnidrectedGraph graph, int v, int u) {
        marked[v] = true;
        for (int w : graph.getArrayOfConections(v))
            if (!marked[w])
                dfs(graph, w, v);
            else if (w != u)
                hasCycle = true;
    }

    public boolean hasCycle() {
        return hasCycle;
    }
```