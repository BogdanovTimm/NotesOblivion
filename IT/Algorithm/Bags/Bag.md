# What it is?

Bas is a data structure that allows you to store elements.

# Code

We will create Bag using Linked List:

```java
public class Bag<Item> implements Iterable<Item> {
    /**
     * First node in list
     */
    private Node first;

    private class Node {
        Item item;
        Node next;
    }

    public void add(Item item) {
        Node oldfirst = first;
        first = new Node();
        first.item = item;
        first.next = oldfirst;
    }

    public Iterator<Item> iterator() {
        return new ListIterator();
    }

    private class ListIterator implements Iterator<Item> {
        private Node current = first;

        public boolean hasNext() {
            return current != null;
        }

        public void remove() {
            // It needs to be empty because Bag does not allow to remove elements from itself
        }

        public Item next() {
            Item item = current.item;
            current = current.next;
            return item;
        }
    }
}
```