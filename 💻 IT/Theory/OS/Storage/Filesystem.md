#                  Inode

Inode is a `struct` that holds the meta-data about some file.

All inodes reside on disk.

A copy of active INodes are usually cached in memory to speed up access.

I-Node is a C-struct contains:
* ID of device containing file
* Inode number (I-Number) - Numeric id of a file (it's low-level name)
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

##                 Pointer to the HDD-Address


Types of pointers to the actual HDD-Address (In comparing the two approaches, pointer-based approaches are the most flexible but use a large amount of metadata per file (particularly for large files). Extent-based approaches are less flexible but more compact; in particular, they work well when there is enough free space on the disk and files can be laid out contiguously (which is the goal for virtually any file allocation policy anyhow)):
* One of the most important decisions in the design of the inode is how it refers to where data blocks are. One simple approach would be to have one or more direct pointers (disk addresses) inside the inode; each pointer refers to one disk block that belongs to the file. Such an approach is limited: for example, if you want to have a file that is really big (e.g., bigger than the block size multiplied by the number of direct pointers in the inode), you are out of luck. Used by: too old to be used in modern times.
* To support bigger files, file system designers have had to introduce different structures within inodes. One common idea is to have a special pointer known as an indirect pointer. Instead of pointing to a block that contains user data, it points to a block that contains more pointers, each of which point to user data. Thus, an inode may have some fixed number of direct pointers (e.g., 12), and a single indirect pointer. If a file grows large enough, an indirect block is allocated (from the data-block region of the disk), and the inode’s slot for an indirect pointer is set to point to it. Not surprisingly, in such an approach, you might want to support even larger files. To do so, just add another pointer to the inode: the double indirect pointer. This pointer refers to a block that contains pointers to indirect blocks, each of which contain pointers to data blocks. A double indirect block thus adds the possibility to grow files with an additional 1024 · 1024 or 1-million 4KB blocks, in other words supporting files that are over 4GB in size. You may want even more, though, and we bet you know where this is headed: the triple indirect pointer. Used by: ext2, ext3, WAFL
* A different approach is to use extents instead of pointers. An extent is simply a disk pointer plus a length (in blocks); thus, instead of requiring a pointer for every block of a file, all one needs is a pointer and a length to specify the on-disk location of a file. Just a single extent is limiting, as one may have trouble finding a contiguous chunk of on-disk free space when allocating a file. Thus, extent-based file systems often allow for more than one extent, thus giving more freedom to the file system during file allocation. Used by: SGI XFS, ext4









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