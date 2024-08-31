#                   What it is? 

It is when 1 core of CPU is non-parallelly runs more tgan 1 program. 

It works like this:
1) OS starts a timer for a few milliseconds
2) OS runs some program 1
3) When timer is off, program 1 return control to the OS
4) OS desides whether to:
    * Return control back to program 1:
        1) OS starts a timer for a few milliseconds
        2) OS runs some program 1
        3) When timer is off, program 1 return control to the OS
        4) Back to 4)
    * Give control to a program 2:
        1) OS perform a context switch (saves arguments, etc from pgrogram 1 and loads arguments, etc of program 2)
        2) OS starts a timer for a few milliseconds
        3) OS runs some program 2
        4) When timer is off, program 2 return control to the OS
        5) Back to 4)