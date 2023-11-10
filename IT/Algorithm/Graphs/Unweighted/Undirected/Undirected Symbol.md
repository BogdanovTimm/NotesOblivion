# What it is?

Symbol graph is a graph in which nodes may have names.

# Code

```java
public class SymbolGraph {

    private Map<String, Integer> st; // String -> index
    private String[] keys; // index -> String
    private UnidrectedGraph G; // the graph

    public SymbolGraph(String stream, String sp) {
        st = new HashMap<String, Integer>();
        Scanner userConsoleInputField = new Scanner(stream);
        while (userConsoleInputField.hasNextLine()) { // builds the index
            String[] a = userConsoleInputField.nextLine().split(sp); // by reading strings
            for (int i = 0; i < a.length; i++) { // to associate each
                if (!st.containsKey(a[i])) { // distinct string
                    st.put(a[i], st.size()); // with an index.
                }
            }
        }
        keys = new String[st.size()]; // Inverted index
        for (String name : st.keySet()) { // to get string keys
            keys[st.get(name)] = name; // is an array.
        }
        G = new UnidrectedGraph(st.size());
        userConsoleInputField.close();
        userConsoleInputField = new Scanner(stream);// Second pass
        while (userConsoleInputField.hasNextLine()) { // builds the graph
            String[] a = userConsoleInputField.nextLine().split(sp); // by connecting the
            int v = st.get(a[0]); // first vertex
            for (int i = 1; i < a.length; i++) {// on each line
                G.addBridge(v, st.get(a[i])); // to all the others.
            }
        }
        userConsoleInputField.close();
    }

    public boolean contains(String s) {
        return st.containsKey(s);
    }

    public int index(String s) {
        return st.get(s);
    }

     public String name(int v) {
        return keys[v];
    }

    public UnidrectedGraph G() {
        return G;
    }
}
```