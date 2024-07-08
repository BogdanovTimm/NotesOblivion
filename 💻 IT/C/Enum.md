```C
enum corvid { 
        magpie,     // magpie = 0
        raven,      // raven  = 1
        jay,        // jay    = 2
        corvid_num, // corvid_num = 3
    };
    char const* const bird[corvid_num] = { 
       [raven]  = "raven", 
       [magpie] = "magpie", 
       [jay]    = "jay", 
    };
    for (unsigned i = 0; i < corvid_num; ++i) {
        printf("Corvid %u is the %s\n", 
               i, 
               bird[i]
        );
    }
```