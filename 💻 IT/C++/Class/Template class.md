```cpp
tempiate<class Т> class myarray {
    /*..*/
};

template <class K, class V, template <class T> class С = myarray>  class Map {  
    C<K> key; 
    C<V> value;  
};
```

