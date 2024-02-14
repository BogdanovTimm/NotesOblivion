#                What it is?

Because when you delete row in PostgreSQL you actually not delete it, but simply move it to an analog of a Windows trash can, you need to use `VACUUM` to actually delete them (also, old versions of updated rows too go to trash can).










#              Command

`VACUUM %tablename%`  - imagine: actual rows in your table occupy 10Gb of HDD space. Old versions of updated rows and deleted rows occupy 1Gb of HDD space. So, your table occupies 11Gb of HDD space. When you use `VACUUM` your table also will occupy 11Gb of space, but 1Gb of space may be reused.

`VACUUM FULL %tablename%` - imagine: actual rows in your table occupy 10Gb of HDD space. Old versions of updated rows and deleted rows occupy 1Gb of HDD space. So, your table occupies 11Gb of HDD space. When you use `VACUUM FULL` your table now will occupy only 10Gb of space.