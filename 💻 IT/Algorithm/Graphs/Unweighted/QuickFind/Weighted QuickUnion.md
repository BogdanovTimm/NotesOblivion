# What it is?

First, you should know that Weighted in the name of this graph doesn't means that it's connections have weights. It means that its speed is improved.

This graph like a [[QuickFind]] represents only whether 2 Nodes belongs to the same group or not. But, this data structure is faster than the mere QuickFind, because Weighted QuickUnion create a weighted Tree from Nodes - each Node points to other Node or to itself. If some Node points to another Node - that means that they are in a same group. If Node point to itself - that means that this node may or may not be in a group.

Though Node1 may point to Node0 - it doesn't bother us, because this data structure is used only to represent whether 2 Nodes belongs to the same group or not. This data structure in not used for represent that Node1 points to Node0.

# Code

```java
public class WeightedQuickUnion {
    /**
     * Represents forest-graph as an array.
     * <p>Each array's position represents a node.
     * <p>Value for every array's position represents parent-node of that node
     * (If node points to itself - it doesn't have a parent)
     * <p>This forest-graph:<code>(0)-(1)-(2) (3)-(4)</code>
     * <p>Can be represented as an array: <code>{0, 0, 1, 3, 3}
     */
    private int[] arrayOfParents;
    /**
     * Represents size of a subtrees of childs for every node.
     * <p>Array's position represents a node.
     * <p>Value for position represents a size of a subtree of childs for this node
     * (1 means that it doesn't have children)
     */
    private int[] arrayOfSubtrees;

    private int amountOfNodes;

    public WeightedQuickUnion(int givenAmountOfNodes) {
        amountOfNodes = givenAmountOfNodes;
        arrayOfParents = new int[givenAmountOfNodes];
        for (int currentPosition = 0; currentPosition < givenAmountOfNodes; currentPosition++) {
            arrayOfParents[currentPosition] = currentPosition;
        }
        arrayOfSubtrees = new int[givenAmountOfNodes];
        for (int i = 0; i < givenAmountOfNodes; i++)
            arrayOfSubtrees[i] = 1;
    }

    public int count() {
        return amountOfNodes;
    }

    public boolean isConnected(int node1, int node2) {
        return findRoot(node1) == findRoot(node2);
    }

    /**
     * Because <code>node = arrayOfParents[node]</code> means that this element is a root,
     * we seek for element in array, which position in array equals to its value.
     */
    private int findRoot(int currentNode) {
        while (currentNode != arrayOfParents[currentNode]) {
            currentNode = arrayOfParents[currentNode];
        }
        return currentNode;
    }
  
    public void weightedUnion(int node1, int node2) {
        int rootOfNode1 = findRoot(node1);
        int rootOfNode2 = findRoot(node2);
        if (rootOfNode1 == rootOfNode2) //? If it is true - it means they are already connected
            return;
        //? Makes smaller root point to larger one --V
        if (arrayOfSubtrees[rootOfNode1] < arrayOfSubtrees[rootOfNode2]) {
            arrayOfParents[rootOfNode1] = rootOfNode2;
            arrayOfSubtrees[rootOfNode2] += arrayOfSubtrees[rootOfNode1];
        } else {
            arrayOfParents[rootOfNode2] = rootOfNode1;
            arrayOfSubtrees[rootOfNode1] += arrayOfSubtrees[rootOfNode2];
        }
        //? Makes smaller root point to larger one --^
        amountOfNodes--;
    }
}
```