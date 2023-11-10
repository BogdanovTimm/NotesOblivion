# What it is?

This data structure represents weighted undirected grap. It is like [[Undirected Graph]] but with weighted connections (edges).

# Code

```java
public class EdgeWeightedGraph {

    private final int amountOfNodes; // number of vertices
    private int amountOfEdges; // number of edges
    private Bag<Edge>[] bagOfEdges; // adjacency lists

    public EdgeWeightedGraph(int amountOfNodes) {
        this.amountOfNodes = amountOfNodes;
        this.amountOfEdges = 0;
        bagOfEdges = (Bag<Edge>[])new Bag[amountOfNodes];
        for (int currentNode = 0; currentNode < amountOfNodes; currentNode++) {
            bagOfEdges[currentNode] = new Bag<Edge>();
        }
    }
  
    public int getAmountOfNodes() {
        return amountOfNodes;
    }
  
    public int getAmountOfEdges() {
        return amountOfEdges;
    }
  
    public void addConnection(Edge conneciton) {
        int node = conneciton.either();
        int node2 = conneciton.other(node);
        bagOfEdges[node].add(conneciton);
        bagOfEdges[node2].add(conneciton);
        amountOfEdges++;
    }
  
    public Iterable<Edge> getConnecitons(int node) {
        return bagOfEdges[node];
    }
  
    public Iterable<Edge> getAllEdges() {
        Bag<Edge> copyOfBagOfEdges = new Bag<Edge>();
        for (int currentNode = 0; currentNode < amountOfNodes; currentNode++) {
            for (Edge currentEdge : bagOfEdges[currentNode]) {
                if (currentEdge.other(currentNode) > currentNode) {
                    copyOfBagOfEdges.add(currentEdge);
                }
            }
        }
        return copyOfBagOfEdges;
    }
}
```