# What it is?

This algorithm checks whether given undirected graph is a Biparite graph. Biparite graph is a graph in which:
- All nodes from biparite graph can be divide on 2 groups
- Each node in group1 will be connected only with nodes in the group2.
- Each node in group2 will be connected only with nodes in group1.
- Nodes in group1 will not be connected with nodes in group1.
- Nodes in group2 will not be connected with nodes in group2.

# Code

```java
public class TwoColor {

    private boolean[] marked;
    private boolean[] color;
    private boolean isTwoColorable = true;

    public TwoColor(UnidrectedGraph graph) {
        marked = new boolean[graph.getAmountOfNodes()];
        color = new boolean[graph.getAmountOfNodes()];
        for (int s = 0; s < graph.getAmountOfNodes(); s++) {
            if (!marked[s]) {
                findConnectedNodes(graph, s);
            }
        }
    }

    public boolean isBipartite() {
        return isTwoColorable;
    }
    
    private void findConnectedNodes(UnidrectedGraph graph, int v) {
        marked[v] = true;
        for (int w : graph.getArrayOfConections(v)) {
            if (!marked[w]) {
                color[w] = !color[v];
                findConnectedNodes(graph, w);
            } else if (color[w] == color[v]) {
                isTwoColorable = false;
            }
        }
    }
}
```