```C
enum enum_name { 
    magpie,      // magpie = 0
    raven,       // raven  = 1
    jay,         // jay    = 2
    enum_length, // corvid_num = 3
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