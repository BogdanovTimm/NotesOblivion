#                  Structure of the HDD

HDD-Disk is divided into blocks of, say, 4KB.

Different blocks play different roles:
* Store data
* Table of `Inodes`-`struct`s - for both files, hard-links, folders, and soft-links. It may be stored in the different place on the HDD or near the data it points to.
* Allocation structures - tracks whether other blocks are free or holds data/`Inodes`. These structures may be different for blocks that keep data or Inodes. There may be placed either in the different place on the disk (and thus track free blocks for entire disk) or in every block-group (and thus track free blocks of this group it is in). It may be:
    * Free List - there is a single pointer in the Superblock that points to the 1st free block. 1st free block keeps pointer to the next free block and so on.
    * Bitmap - each bit say whether block is free (0) or in use (1)
* Superblock - keeps information about file system, so the OS may know what it needs to do:
    * Number of blocks
    * Where the Table of the Inodes begins
    * File system type
    * other...










#                  Disk Virtualization

Disks export a logical address space of blocks and hide details of their physical geometry from clients.







#                  Searching speed

If 2 files are in the one block group - then they will be accessed fast from each other.










#                  Inode

Inode is a `struct` that holds the meta-data about some file, hard-link, soft link, or directory.

All inodes reside on disk.

A copy of active INodes are usually cached in memory to speed up access.

`Inode` is a C-`struct` that contains:
* ID of device containing file
* Inode number (I-Number) - Numeric id of a file (it's low-level name). Inodes are find by it
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
.
Folder is a file that contains pairs of human-readable name of a file/folder and its I-Node.
Folders have its `Inode` with metadata in the Table of the Inodes and itself kept in the data blocks.

Directories stores C-structs `dirent` that stores:
* `char           d_name[256]` - Filename
* `ino_t          d_ino`       - Inode number
* `off_t          d_off`       - Offset to the next `dirent`-struct
* `unsigned short d_reclen`    - Length of this record
* `unsigned char  d_type`      - Type of file










#                  Chache and Buffers

Because I/O is itself very slow, OS uses 2 ides to improve the speed:
* Chaching - it stores popular data-blocks and so no I/O is needed:
    * It may be a special cache only for HDD data
    * Unified Page Cache - cache for both RAM and HDD data
* Buffering aka Immediate Reporing - it is when OS saves data to write into some buffer in the RAM. Later, it will write this buffer to the HDD using I/O. Also, if it was some temporary file that was written in buffer and was deleted before the I/O started - it may avoid both write and delete I/O by leaving interily in the RAM buffer. Most OSes flushes buffer once in 5-30 seconds. If you need to 








#                  Working with files

##                 Creating a file

When you create a file you do:
* Create an `inode`-structure
* Map `inode` with a human-readable name and adds them both to the `dirent`-structure of the directory the file will be placed


The amount of write traffic is even worse when one considers a simple and common operation such as file creation. To create a file, the file
system must not only allocate an inode, but also allocate space within
the directory containing the new file. The total amount of I/O traffic to
do so is quite high: one read to the inode bitmap (to find a free inode),
one write to the inode bitmap (to mark it allocated), one write to the new
inode itself (to initialize it), one to the data of the directory (to link the
high-level name of the file to its inode number), and one read and write
to the directory inode to update it. If the directory needs to grow to accommodate the new entry, additional I/Os (i.e., to the data bitmap, and
the new directory block) will be needed too. All that just to create a file!









##                 Reading a file

Steps of reading a file:
1) `open(/folder1/folder2/file.txt)`:
    1. Read a root    Inode       - OS always knows its Inode. Finds where a root data-block is
    2. Read a root    data-bclock - finds the Inode-number of the folder1 Inode
    3. Update last-access time of the `/` folder in its Inode
    4. Read a folder1 Inode       - finds where a folder1 data-block is
    5. Read a folder1 data-block  - finds the Inode-number of the folder2 Inode
    6. Update last-access time of the `/folder1/` in its Inode
    7. Read a folder2 Inode       - finds where a folder2 data-block is
    8. Read a folder2 data-block  - finds the Inode-number of the file.txt
    9. Update last-access time of the `/folder1/folder2/` in its Inode
    10. Read a file.txt Inode      - finds where a file.txt data-block is
    11. FS checks permissions
    12. FS allocates a **File-Descriptor** for this process in the per-process open-file table, and returns it to the user
2) `read()`:
    1. Reads a 1st data-block of the file
    2. Updates last-access time of the file in the file.txt Inode
    3. Update RAM open file table for this file descriptor by updating the file offset (so, the next read will read the second file block)
3) `read()` - if file was not closed yet. It will do same as in the 2) step
4) `close()` -  Deallocates the **File-Descriptor**









##                 Writing into a file

Each write to a file generates 5 I/Os:
* Read the Bitmap
* Write the Bitmap to reflect its new state to disk
* Read the file's Inode
* Write the file's Inode, which is updated with the new block’s location
* Write the actual file's data-block itself










##                 Deleting a file

When you delete a file, you call `unlink()` system-call. It checks whether a Number of hard links in the `inode`-structure of the file is > 0. If it is not - then, it just deletes a hard-link to a file. If it is 0, then it also deletes an `inode`-structure and frees the data-blocks.









#                  Types of entities in the OS

Types of the entities:
* File
* Folder/Directory
* Soft Link









#                  File Descriptor

In this way, a file descriptor is a capability [L84], i.e., an opaque handle that gives you the power to perform certain operations. Another way to think of a file descriptor is as a pointer to an object of type file; once you have such an object, you can call other “methods” to access the file, like read() and write() (we’ll see how to do so below).









#                  Chrash-Consistency

2 ways:
* File System Checker aka `fsck` - let inconsistency be and just fix it with `fsck`:
    * Checks the superblock whether it is corrupted
    * Checks whether the Bitmap is same as the Inodes. If not, it trust the Inodes
    * Check Inode state
    * Checks whether Inode link number is correct and fix it if not
    * Finds whether there is a situation when 2 Inodes points to a same block
* Journaling aka Write-ahead log - Used by  ext3, ext4, reiserfs, IBM’s JFS, SGI’s XFS, and Windows NTFS