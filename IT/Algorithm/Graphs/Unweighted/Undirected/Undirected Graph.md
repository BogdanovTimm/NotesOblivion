# What it is?

![[Pasted image 20231110190311.png]]

Undirected graph is the graph in which if Node1 is connected with Node2, Node2 always connected to Node1.

# Code

```java
public class UnidrectedGraph {

    private final int amountOfNodes;
    private int amountOfBridges;

    /**
     * Each position represents nodes, that are connected with some node. So:
     * <p>
     * <code>{1, 1, 0}</code> means:
     * <p>
     * <code>1---0---2</code>
     */
    private Bag<Integer>[] arrayOfConnections;

    public UnidrectedGraph(int amountOfNodes) {
        this.amountOfNodes = amountOfNodes;
        this.amountOfBridges = 0;
        arrayOfConnections = (Bag<Integer>[])new Bag[amountOfNodes];
        for (int v = 0; v < amountOfNodes; v++)
            arrayOfConnections[v] = new Bag<Integer>();
    }

    public UnidrectedGraph(String in) {
        this(setNodes(in));
        try (var parser = new Scanner(in)) {
            var V = parser.nextInt(); // We've already get this, so just leave it like that.
            amountOfBridges = parser.nextInt();
            for (int i = 0; i < amountOfBridges; i++) { // Add an edge.
                int v = parser.nextInt(); // Read a vertex,
                int w = parser.nextInt(); // read another vertex,
                addBridge(v, w); // and add edge connecting them.
            }
        }
    }

    public int getAmountOfNodes() {
        return amountOfNodes;
    }

    public int getAmountOfBridges() {
        return amountOfBridges;
    }

    public void addBridge(int node1, int node2) {
        arrayOfConnections[node1].add(node2); // Add w to v’s list.
        arrayOfConnections[node2].add(node1); // Add v to w’s list.
        amountOfBridges++;
    }

    public Iterable<Integer> getArrayOfConections(int v) {
        return arrayOfConnections[v];
    }

    static private int setNodes(String in) {
        try (var parser = new Scanner(in)) {
            return parser.nextInt();
        }
    }

    /**
     * Returns how much connections a given node has
     */
    public int degree(int positionOfGivenNode) {
        int amountOfConnections = 0;
        for (int currentConnection : getArrayOfConections(positionOfGivenNode))
            amountOfConnections++;
        return amountOfConnections;
    }

    public int maxDegree() {
        int currentMaximumAmountOfConnecitons = 0;
        for (int currentNode = 0; currentNode < getAmountOfNodes(); currentNode++) {
            if (degree(currentNode) > currentMaximumAmountOfConnecitons) {
                currentMaximumAmountOfConnecitons = degree(currentNode);
            }
        }
        return currentMaximumAmountOfConnecitons;
    }

    public int averageDegree() {
        return 2 * getAmountOfBridges() / getAmountOfNodes();
    }

    public int numberOfSelfLoops() {
        int count = 0;
        for (int v = 0; v < getAmountOfNodes(); v++) {
            for (int w : getArrayOfConections(v)) {
                if (v == w) {
                    count++;
                }
            }
        }
        return count / 2; // each edge counted twice
    }

    public String toString() {
        String currentString = amountOfNodes + " vertices, " + amountOfBridges + " edges\n";
        for (int currentNode = 0; currentNode < amountOfNodes; currentNode++) {
            currentString += currentNode + ": ";
            for (int currentAmountOfConnectons : this.getArrayOfConections(currentNode)) {
                currentString += currentAmountOfConnectons + " ";
            }
            currentString += "\n";
        }
        return currentString;
    }
}
```