#                  Inode

All inodes reside on disk.

A copy of active INodes are usually cached in memory to speed up access.

I-Node is a C-struct contains:
* ID of device containing file
* Inode number - Numeric id of a file (it's low-level name)
* Protection
* Number of hard links
* User ID of owner
* Group ID of owner
* Device ID (if special file)
* Total size, in bytes
* Blocksize for filesystem I/O
* Number of blocks allocated
* Time of last access
* Time of last modification
* Time of last status change









#                  Directory aka Folder

Folder is a file that contains pairs of human-readable name of a file/folder and its I-Node.
Folders have I-Node name.

Directories stores keeps C-structs `dirent` that stores:
* `char           d_name[256]` - Filename
* `ino_t          d_ino`       - Inode number
* `off_t          d_off`       - Offset to the next `dirent`-struct
* `unsigned short d_reclen`    - Length of this record
* `unsigned char  d_type`      - Type of file









#                  Working with files

##                 Creating a file

When you create a file you do:
* Create an `inode`-structure
* Map `inode` with a human-readable name and adds them both to the `dirent`-structure of the directory the file will be placed









##                 Deleting a file

When you delete a file, you call `unlink()` system-call. It checks whether a Number of hard links in the `inode`-structure of the file is > 0. If it is not - then, it just deletes a hard-link to a file. If it is 0, then it also deletes an `inode`-structure and frees the data-blocks.









#                  Types of entities in the OS

Types of the entities:
* File
* Folder/Directory
* Soft Link









#                  File Descriptor

In this way, a file descriptor is a capability [L84], i.e., an opaque handle that gives you the power to perform certain operations. Another way to think of a file descriptor is as a pointer to an object of type file; once you have such an object, you can call other “methods” to access the file, like read() and write() (we’ll see how to do so below).