#                  What it is

It is a way to allow more than 1 user to have rights.

#                  Code

`getfacl xFOLDERx` - shows current facl-rights for a given folder

`setfacl -b xFOLDERx` - removes current facl-rights for a given folder

Add new rules to the existing one:
```
setfacl -m \
user::rwx,\
user:USER1:rwx,\
user:USER2:rwx,\
group::r-x,\
mask::rwx,\
other::---,\
default:user::rwx,\
default:user:USER1:rwx,\
default:user:USER2:rwx,\
default:group::r-x,\
default:mask::rwx,\
default:other::--- \
/F/O/L/D/E/R
``` 