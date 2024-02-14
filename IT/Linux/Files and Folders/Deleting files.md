# Deleting when somebody uses file

When somebody use file, if you delete that file, it just deletes file descriptor, but Linux will not free space on HDD from it (imagine that with file on 500Gb).

1. `lsof | grep %file_to_delete.txt%` - so, **always** check that file is not in use by somebody
2. `echo "" >%file_to_delete.txt%` - To safely free HDD space, use this 