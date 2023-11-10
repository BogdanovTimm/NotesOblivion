# What it is?

![[Pasted image 20231110210358.png]]

QuickFInd is a graph that represents groups of elements. We don't know how they are connected between themselves within the group - we only know that they are in a same or in a different group.

# Code

We use an array to represent it. Position of an array represents a Node. Value of some position represents a group to which this Node belongs.

```java
public class QuickFind {

    private int[] nodeAndTheirGroups;

    public QuickFind(int arraySize) {
        nodeAndTheirGroups = new int[arraySize];
    }
  
    public boolean isConnected(int element1, int element2) {
        return nodeAndTheirGroups[element1] == nodeAndTheirGroups[element2];
    }
  
    /**
     * Slowest way to union nodes.
     * <p>Each position represents a node
     * <p>Value of each position represents a group to which node belongs
     */
    public void union(int element1, int element2) {
        int groupOfElement1 = nodeAndTheirGroups[element1];
        int groupOfElement2 = nodeAndTheirGroups[element2];
        for (int currentPosition = 0; currentPosition < nodeAndTheirGroups.length; currentPosition++) {
            if (nodeAndTheirGroups[currentPosition] == groupOfElement1) {
                nodeAndTheirGroups[currentPosition] = groupOfElement2;
            }
        }
    }
}
```