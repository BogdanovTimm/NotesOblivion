# What it is?

Minimum Spanning Tree (MST) is a graph that can be made from a given graph:
- Minimum Spanning Tree graph will have all nodes from original graph
- Minimum Spanning Tree graph will have minimal amount of connections between nodes such that all nodes will be connected

# Code

This code uses Kruskal's version of this Algorithm.

This algorithm uses [[Min Priority Queue]], [[Edge Undirected Weighted]], [[Undirected Weighted Graph]] and [[Weighted QuickUnion]].

```java
public class KruskalMST {

    private static final double FLOATING_POINT_EPSILON = 1E-12;
    private double weight;                        // weight of MST
    private Queue<Edge> mst = new Queue<Edge>();  // edges in MST

    /**
     * Compute a minimum spanning tree (or forest) of an edge-weighted graph.
     */
    public KruskalMST(EdgeWeightedGraph G) {
        MinPQ<Edge> pq = new MinPQ<Edge>();
        for (Edge e : G.getAllEdges()) {
            pq.insert(e);
        }
        // run greedy algorithm
        WeightedQuickUnion uf = new WeightedQuickUnion(G.getAmountOfNodes()); //!UF
        while (!pq.isEmpty() && mst.size() < G.getAmountOfNodes() - 1) {
            Edge e = pq.delMin();
            int v = e.either();
            int w = e.other(v);
            if (!uf.isConnected(v, w)) { // v-w does not create a cycle
                uf.weightedUnion(v, w);  // merge v and w components
                mst.enqueue(e);  // add edge e to mst
                weight += e.weight();
            }
        }
        // check optimality conditions
        assert check(G);
    }

    /**
     * Returns the edges in a minimum spanning tree (or forest) as an iterable of edges
     */
    public Iterable<Edge> edges() {
        return mst;
    }
  
    /**
     * Returns the sum of the edge weights in a minimum spanning tree (or forest).
     */
    public double weight() {
        return weight;
    }
  
    /**
     * check optimality conditions (takes time proportional to E V lg* V)
     */
    private boolean check(EdgeWeightedGraph G) {
        // check total weight
        double total = 0.0;
        for (Edge e : edges()) {
            total += e.weight();
        }
        if (Math.abs(total - weight()) > FLOATING_POINT_EPSILON) {
            System.err.printf("Weight of edges does not equal weight(): %f vs. %f\n", total, weight());
            return false;
        }
        // check that it is acyclic
        WeightedQuickUnion uf = new WeightedQuickUnion(G.getAmountOfNodes());
        for (Edge e : edges()) {
            int v = e.either(), w = e.other(v);
            if (uf.isConnected(v, w)) {
                System.err.println("Not a forest");
                return false;
            }
            uf.weightedUnion(v, w);
        }
        // check that it is a spanning forest
        for (Edge e : G.getAllEdges()) {
            int v = e.either(), w = e.other(v);
            if (!uf.isConnected(v, w)) {
                System.err.println("Not a spanning forest");
                return false;
            }
        }
        // check that it is a minimal spanning forest (cut optimality conditions)
        for (Edge e : edges()) {
            // all edges in MST except e
            uf = new WeightedQuickUnion(G.getAmountOfNodes());
            for (Edge f : mst) {
                int x = f.either(), y = f.other(x);
                if (f != e)
                    uf.weightedUnion(x, y);
            }
            // check that e is min weight edge in crossing cut
            for (Edge f : G.getAllEdges()) {
                int x = f.either(), y = f.other(x);
                if (!uf.isConnected(x, y)) {
                    if (f.weight() < e.weight()) {
                        System.err.println("Edge " + f + " violates cut optimality conditions");
                        return false;
                    }
                }
            }
  
        }
        return true;
    }
}
```