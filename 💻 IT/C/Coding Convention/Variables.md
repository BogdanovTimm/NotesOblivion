Names starting with an underscore and a second underscore or a capital letter are reserved for language extensions and other internal use. 
• Names starting with an underscore are reserved for file scope identifiers and for enum, struct and union tags. 
• Macros have all-caps names. 
• All identifiers that have a predefined meaning are reserved and cannot be used in file scope. This includes a lot of identifiers, such as all functions in the C library, all identifiers starting with str (like our strip, earlier), all identifiers starting with E, all identifiers ending in _t, and many more. 