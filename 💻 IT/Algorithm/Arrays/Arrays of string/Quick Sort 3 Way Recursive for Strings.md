# What it is?

It is the fastest algorithm for sorting an array of Strings

# Code

```java
public class Quick3string {

    public static void sort(String[] a) {
        innerRecursiveFunction(a, 0, a.length - 1, 0);
    }

    private static void innerRecursiveFunction(String[] a, int lo, int hi, int d) {
        if (hi <= lo) {
            return;
        }
        int lt = lo;
        int gt = hi;
        int v = charAt(a[lo], d);
        int i = lo + 1;
        while (i <= gt) {
            int t = charAt(a[i], d);
            if (t < v) {
                swap(a, lt++, i++);
            } else if (t > v) {
                swap(a, i, gt--);
            } else {
                i++;
            }
        }
        innerRecursiveFunction(a, lo, lt - 1, d);
        if (v >= 0) {
            innerRecursiveFunction(a, lt, gt, d + 1);
        }
        innerRecursiveFunction(a, gt + 1, hi, d);
    }
  
    private static int charAt(String s, int d) {
        if (d < s.length()) {
	        return s.charAt(d);
        } else {
            return -1;
        }
    }

    public static void swap(String[] array, int position1, int position2) {
        String valueFromPosition1 = array[position1];
        array[position1] = array[position2];
        array[position2] = valueFromPosition1;
    }

}
```