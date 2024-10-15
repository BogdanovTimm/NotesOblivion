# What it is

Package (aka Library) is a directory with `file.py`s









# How to import package

## '--- Whole module

```Python
import xPACKAGE_NAMEx.xSUBPACKAGE_NAMEx.xMODULE_NAMEx
xMODULE_NAMEx.xFUNCITON_FROM_MOUDLE_NAMEx()
```




## '--- Only specific functions

```Python
from xPACKAGE_NAMEx.xSUBPACKAGE_NAMEx.xMODULE_NAMEx import xFUNCITON_FROM_MOUDLE_NAMEx
xMODULE_NAMEx.xFUNCITON_FROM_MOUDLE_NAMEx()
```

Alternative way:

```Python
import xPACKAGE_NAMEx.xSUBPACKAGE_NAMEx.xMODULE_NAMEx.xFUNCITON_FROM_MOUDLE_NAMEx
xMODULE_NAMEx.xFUNCITON_FROM_MOUDLE_NAMEx()
```