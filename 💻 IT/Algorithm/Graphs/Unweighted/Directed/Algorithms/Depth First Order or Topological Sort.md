# What it is?

This algorithm finds order for given Directed Acyclic Graph (DAG). The order work like that:
1. First there will be Node (or Nodes) that doesn't have any connection that points to this node (this Node will have only connections that goest from itself to some other Node)
2. Next, there will be Nodes that have 1 connection to itself
3. Next, there will be Nodes that have 2 connections to itself...

# Code

```java
public class DepthFirstOrder {

    private boolean[] marked;
    private SingleLinkedListQueue<Integer> pre; // vertices in preorder
    private SingleLinkedListQueue<Integer> post; // vertices in postorder
    private ResizingArrayStack<Integer> reversePost; // vertices in reverse postorder

    public DepthFirstOrder(Digraph graph) {
        pre = new SingleLinkedListQueue<Integer>();
        post = new SingleLinkedListQueue<Integer>();
        reversePost = new ResizingArrayStack<Integer>();
        marked = new boolean[graph.V()];
        for (int v = 0; v < graph.V(); v++) {
            if (!marked[v]) {
                findConnectedNodes(graph, v);
            }
        }
    }

    private void findConnectedNodes(Digraph G, int v) {
        pre.enqueue(v);
        marked[v] = true;
        for (int w : G.adj(v))
            if (!marked[w])
                findConnectedNodes(G, w);
        post.enqueue(v);
        reversePost.push(v);
    }

    public Iterable<Integer> pre() {
        return pre;
    }

    public Iterable<Integer> post() {
        return post;
    }
    
    /**
     * Returns topological sort
     */
    public Iterable<Integer> reversePost() {
        return reversePost;
    }
}
```