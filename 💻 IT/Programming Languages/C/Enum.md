```C
    enum enum_name { 
        magpie = 5,
        raven = 4,
        jay = 9,
        enum_length = 10,
    };
    char const* const array_name[enum_length] = { 
       [raven]  = "raven", 
       [magpie] = "magpie", 
       [jay]    = "jay", 
    };
    for (unsigned i = 0; i < enum_length; ++i) {
        printf("Corvid %u is the %s\n", 
               i, 
               array_name[i]
        );
    } 
```