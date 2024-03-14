#                  In Use

In Use is the amount of physical memory (RAM) that corresponds to virtual pages that can be accessed without incurring a page fault.

Caution: It is not the amount of virtual memory that can be accessed without incurring a page fault! That's a larger number. Many different virtual pages can be mapped to the same physical page.

Background: Each virtual page can be either "valid", which means it occupies physical memory and its page table entry has the "valid" bit set. Or else the valid bit can be clear, in which case referencing the virtual page will incur a page fault. Then the OS has to resolve the fault. The page is then said to have been "faulted in" to RAM. This is commonly assumed to mean "reading the page from disk", but that is often not the case (details later). Another term that you'll hear used for a valid page is "resident".

The major contributor to In use is the pages that comprise the working sets of processes and of the OS, plus the nonpaged pool (which is usually fairly small, a few hundred MB or so - I'll say more about it later). The working set of a process is simply a list of the physical pages that are currently "resident" for that process. Every process has its own working set list.

Note: Physical pages of RAM can be in multiple process's working sets at the same time. This means that adding up the sizes of the working sets of all processes will give you a number that's larger than the actual amount of RAM they're using. The In use total, though, correctly accounts for shared pages; i.e. it does not double- or multi-count them.

Caution: The term In Use can be misleading because pages of RAM on the Standby and Modified lists is arguably "in use" too, even though they can't be accessed without page faults and they're not in any working set. These two lists will be explained a bit more later.

n.b.: A lot of this discussion is going to mention processes and their working sets. The Windows OS's kernel mode code and data lives in virtual memory too, and much of it is pageable. That is, it doesn't have to stay in RAM all the time, any more than application code and data have to. While not a process itself (the so-called "System" process notwithstanding), there is a working set to keep track of the pages that are "valid" for the OS—or more precisely, for kernel address space. In fact, as of Windows 7 and later, the system working set was divided into four working sets (for various types of pageable code and data), mostly for performance reasons. Almost everything I talk about regarding working sets applies to the OS's working set(s) as well as to those of processes, but I'm not going to add "or one of the OS working sets" every time I mention a process working set.

#                  Available

You didn't ask about this one, but it's important. Available is all of the RAM that can be assigned to a new use (e.g. to a process other than the one that was previously using it, or even to a new virtual page within the same process) without removing it from a working set and without saving its contents somewhere. (Because the contents are already saved somewhere, if they're important).

Available does not appear on the current Task Manager Performance tab, Memory pane. It is visible in Resource Monitor's Memory tab. It is the sum of the Standby, Free, and Zero page lists. Details on those are coming up.

#                  Cached

The Cached counter on Task Manager's Performance tab is the total of the following three uses of RAM. It is a count of RAM, not of virtual memory.

##                 Cached part 1: the Standby Page List (including SuperFetch)

This is visible on the "Resource Monitor" "Memory" tab. Prior to Windows Vista this was exclusively used as a "page cache": Pages of RAM that are dropped from working sets (after which reference to them would incur a pagefault) are first put on the standby page list. From there they can be reassigned to some other use ("repurposing"). But if the original process references a page on the SPL before that happens, the page can be restored to its original working set (that is, it can be "made valid") without having to read it from disk. The SPL therefore forms a system-wide first-in, first-out cache of pages that might be needed again soon. (As opposed to the working sets, which are per-process; pages are dropped from working sets on least-recently-used basis, not FIFO.)

All of that still applies. But as of Vista and later, some of the pages on the SPL may be repurposed for use by SuperFetch. SuperFetch is a proactive, read-only file caching mechanism that maintains a history of often-accessed files and tries to speed things up by reading such files into RAM before they're actually asked for.

The clever thing about SuperFetch is that pages used by SuperFetch are not removed from the Standby Page List, and so can still be repurposed in a very short time just like anything else on the SPL. And they are still counted as part of Cached. And as part of Available. So SuperFetch doesn't really "use" any RAM! Or at least, it doesn't take away from "Available", nor does it contribute to "In Use".

SuperFetch is disabled by default on systems with an SSD for the OS disk. The Standby list is still used as described here, as a page cache.

The Standby Page List is part of the RAM that is reported as Available, meaning that any and all of its pages can be repurposed for anything else at any moment - even those pages that are in use by SuperFetch. It is not part of In Use, even though it's being used. Certainly SuperFetch is using it! It's also being used every time a soft page fault is resolved to the SPL. All I'm saying here is that claiming that In Use is the amount of RAM "being used" is, at best, misleading. Microsoft should have picked a different term for In Use.

##                 Cached part 2: the Modified Page List

As of Windows 8 and later, the Cached counter also includes physical pages that are on the Modified Page List. (The MPL has been around for forever; all that is new is counting it as part of Cached.) Like the SPL, the size of the MPL can be seen on Resource Monitor's Memory tab, though it usually should be quite small or zero.

The MPL is like the SPL, except that it is used for pages whose contents were modified while they were resident. (This is recorded by the CPU's MMU.) When dropped from their working sets, such pages are moved to the MPL rather than the SPL. "Modified page writer" threads in the "System" process periodically wake up, copy the contents of these pages to their respective backing stores (either the page file or, for file-backed pages, their respective files) and then move them to the standby page list, at which time they become part of Available and are treated just as if they'd been put on the SPL in the first place. They were not part of Available while on the MPL because they can't be repurposed for something else before their contents are saved somewhere.

The MPL is not counted as part of In use either.

Note that if you have (foolishly, and in defiance of good advice) disabled your pagefile the system will never be able to write out pagefile-backed modified pages. The usual symptom here is an absurdly large MPL, which can cause shortages of available RAM, and hence "page thrashing", where the OS is spending more time copying pages into and out of RAM than doing the work you want to do.

The "Compressed memory" feature of Windows 10 has changed the "writing to the pagefile" part of this somewhat; I'm not going to get into that here as it doesn't affect the counters we're talking about.

##                 Cached part 3: the File System Cache

UPDATE: At some point during Windows 10's many versions, or perhaps as early as Windows 8, this no longer is part of Task Manager's Cached counter. But it still exists, and the PerfMon counter I mention is still there and active. The resident size of the File System Cache is still also included in In Use. I have to do some tests to see exactly when this was changed.
or at least the "resident" portion of the File System Cache. Again - "Resident" means it is the in-RAM, in-a-working-set portion of a larger virtual allocation.

Hey, didn't we already talk about a cache? "SuperFetch"? Yes, but this is not the same cache as SuperFetch. Unlike SuperFetch the file system cache is a reactive cache (never predictive - i.e. it never caches anything until it's actually been used, then it's cached for future rapid use (within the same OS instance).

The file cache also has a vital role in supporting file access on boundaries that aren't sector-aligned. If you open a file with the "no caching" option, all of your reads and writes must be in multiples of the drive's sector size and must start on sector boundaries. The file cache lets you read and write just one byte at a time (at least as far as your API calls are concerned).

In earlier versions of Windows the resident part of the file cache was part of the system working set, and its contribution to the system working set could be found in the PerfMon counter Memory | System Cache Resident Bytes. As of Windows 7 and later the system working set has been broken up into four separate working sets, the file cache occupying one of them, and that same counter still reflects its resident size. Either way, the resident portion of the file system cache is included in "in use" (because it's a working set).

n.b.: Task manager's "cached" counter has nothing whatsoever to do with the CPU's internal caches (L1, L2, etc.). Those caches do of course exist but Windows doesn't manage them and they are not reflected in any of the OS's memory management counters - not "total", not "in use", certainly not "cached".

#                  The Nonpaged and Paged Pools

The Paged and Nonpaged counters give the virtual sizes of two regions of kernel address space, called "memory pools". Both are used for fairly small, short-term allocations of memory (usually well under 1 MB each) that are needed by various components of Windows' kernel mode code, including by device drivers. Kernel mode code uses these in a manner very similar to that of application programs using "heaps". (The reason Windows calls them pools instead of heaps is historical.)

One of the pools is Nonpaged meaning it is always kept in RAM. So for this one, the size indicated by Task Manager is the physical (RAM) size as well as the virtual size. The nonpaged pool is used by components that may execute in contexts where page faults cannot be handled, such as device drivers' interrupt service routines, DPC routines, and other routines that must run at IRQL DISPATCH_LEVEL or above. I've explained IRQLs in another answer here.

The other pool, called Paged by Task manager, really should be called "pageable". Just like ordinary virtual memory used by processses, it isn't necessarily paged out, it's just that portions of it can be. As with all other pageable regions its pages will be "faulted in" to RAM on demand - ie when referenced while not in RAM - and possibly "paged out" later if physical memory is running short and new page faults must be resolved.

The size Task Manager shows for the pageable pool is the virtual size. A subset of that will be "valid", i.e. in RAM (ie the physical size). The size of the in-RAM (paged-in) portion of the paged pool is not reported by Task Manager, but can be seen in the SysInternals tool Process Explorer (View | System Information), or in the PerfMon counter Memory | Pool Paged Resident Bytes.

All of the "nonpaged" pool, and the "paged-in" or "resident" portion of the paged pool, are part of what is counted as "in use".

For more information on the kernel memory pools, see the documentation on the kernel interface ExAllocatePool.

Caution: Nonpaged is not the paged-in subset of Paged! These are separate virtual allocations. It is therefore entirely possible, for example, for the nonpaged pool to show with a larger size than the paged - but not common.

Caution: In no way are these the total amount of kernel virtual address space.

#                  Committed

The Committed counters refer to a particular type of virtual memory. To really explain this I have to explain the other types.

Every page of virtual address space can be in one of five states: Unused, nonpageable, mapped, reserved, and committed. "Nonpageable," "Committed" and "mapped" virtual address spaces correspond to virtual memory and can be successfully accessed (read or written), possibly with a page fault along the way; "Unused" and "reserved" cannot be accessed.
(That error message you sometimes see - "The Instruction at 0x(some address) referenced memory at 0x(some address), the memory could not be read" (or "written")? That's what happens if code on your system tries to access "Unused" or "reserved" address space. Or if an attempt is made to write to a read-only page, or to access a kernel-protected virtual address from user mode. n.b.: The address reported is virtual, not physical, and the message does not mean you have a problem with your RAM. It's a bug in the program.)

- "Nonpageable" virtual memory is always physically "resident" and is almost exclusively the province of the Windows kernel mode code. It is part of "in use". The Nonpaged pool, already discussed, is an example of nonpageable virtual memory.
    Caution: Even though nonpageable virtual memory is always resident, we still consider it "virtual" because we still reference it by virtual addresses. It has all the other properties of virtual memory as well, except that it is always "valid" in so will never produce a page fault when accessed.

- "Mapped" virtual address space is pageable to/from disk. Its "backing store" - which is a fancy name for where portions of it are kept if they can't all be kept in RAM at the same time - are files that were provided when each mapped region is created. (The relevant APIs here are CreateFileMapping and MapViewOfFile.) The content of mapped regions in fact starts out in those files; it is read into RAM as it is accessed ("demand paging"). Mapped memory is by the way exceptionally common - it's in mapped regions that all executable code lives. It is also very commonly used to access large files, as opposed to traditional read/write access. Mapped regions may be shared across processes. If the mapping is set up for read/write access (not typically done for code files!), then modifications to the mapped v.a.s. get written back to the respective mapped files. There is however the ability to create a "pagefile-backed mapped region" that can be shared between processes like any other mapped region, but changes to which will not be preserved anywhere once all processes have unmapped it.
- "Committed" virtual address space is also pageable to/from disk. The difference between this and "mapped" is that the backing store for "Committed" v.a.s., if it should be needed, is the pagefile (if you have one, which you most certainly should). "Committed" like "mapped" is demand paged, but the first time a page of committed memory is accessed, there is no reading from disk - because unlike for mapped memory, there is no place to read initial contents from. A new physical page is simply allocated to the process (from previously-"Available" RAM, typically the Zero Page List) and made valid in the process working set. So a page of committed memory occupies no storage space anywhere until the first time it's referenced. Since Committed memory is pageable (even if you don't have a pagefile, but you really should have one), not all of it is likely to be in RAM - "resident" - at the same time. As usual, the OS tries to keep the most-recently-accessed pages of v.a.s. in RAM; if available RAM is scarce then the OS will "page out" other pages, removing them from their working sets and putting them on the SPL or MPL. In the latter case they are soon written to their backing store. The total size of "committed" (that is, pagefile-backed, or it would be if you had a pagefile, which you definitely should), across all processes plus the OS kernel, is that first number under the word Committed. It includes several other contributions too: Chiefly the nonpaged and paged pools, and any mapped regions that are mapped copy-on-write. This number is often  called the commit charge.One way to think of the commit charge is: If you have a pagefile (which you should), and all pageable contents of memory (committed, paged pool, etc.) except for mapped memory had to be paged out of RAM - this is how much pagefile space would be needed. 

The second number under the word Committed is the ''commit limit.'' That's the size of RAM plus the current total size(s) of the pagefile(s). The commit charge isn't allowed to get any larger than that. If a process attempts to commit virtual memory of a size that would exceed the commit limit, then if possible, Windows will enlarge the pagefile to make room (and you will see the "low on memory" pop-up). If enlarging the pagefile is not possible then the message will say "out of memory" and the process that did it will crash.

The resident subset of the Commit charge is part of "in use". Note that even if you don't have a pagefile (and if you don't, what is wrong with you?) this is not necessarily the same as the commit charge. For one thing, if you commit virtual memory but then don't access all of it, the parts you don't access will never occupy any storage anywhere. It is also possible for committed memory to be dropped from a working set and put on the modified page list. Usually, only a subset of committed memory will occupy RAM.

There is no way from Task Manager to determine the subset of committed memory that is in RAM. However, the SysInternals tool "RAMmap" can show this.

#                  Adding it all up

Available + In use + Modified add up to the total RAM usable by the OS.

the total RAM usable by the OS plus the "Hardware Reserved" RAM should equal the total amount of RAM installed.

Available is equal to the Standby Page List, plus the Free Page List, plus the Zero Page List

Free as displayed by Resource Monitor's Memory tab is the sum of the Zero Page List and the Free Page List.

(I have deliberately omitted any more discussion of the Zero Page List because it's not important to the counters asked about.)

Cached = the Standby Page List (some of which is used by SuperFetch), plus (for Windows 8 and later) the Modified Page List, plus (for earlier versions of Windows yet to be precisely determined) the paged-in or resident portion of the system file cache.

Caution: Since the Standby page list is part of both "Available" and "Cached", it is entirely possible to add "Available" and "Cached" and get a total that is larger than the total amount of RAM! These numbers simply aren't meant to be added together.

Resource Monitor's Memory tab shows the sum of Free and Zero as a single number, labeled "Free". Performance Monitor can show you these sizes individually.

#                  Do I have enough RAM?

"As far as i know the kernel manipulates memory management in a complex manner, so can i conclude that if i have free memory in my laptop's ram, so my memory is sufficient?"

The best metric for "do I have enough RAM?" is usually your hard page fault rate. Hard page faults are page faults that require reading from disk. You can see this on the graphs in the right column of Resource Monitor (both "Overview" and "Memory" tabs), or per-process on the Memory tab. The PerfMon counter Memory | Page Reads/sec also shows it.

The overall fault rate is a superset of the hard fault rate and is nowhere near as interesting. It includes "soft page faults", which don't involve disk reads and so take much less time. (It's hard to say how much time they take, but I'd estimate it as being a few hundred instruction times, at most.) These include faults resolved to the standby and modified page lists, faults to shared pages that are already resident for one or more other processes, and "demand zero" faults, which happen upon the first reference to private pages. Don't be surprised if you see thousands of page faults a second. It's the page reads from disk that slow things down tremendously (even if your disk is an SSD).

But what about "Available"? or "Free"?

Many people worry about the amount of "Available" memory, or "Free" memory. First, it is fairly common for a Windows system where not many processes have exited for a long time to show no or almost no free memory. This is expected as the only event that typically returns memory to "Free" is when a process exits; physical pages that were valid for its "committed" memory are then moved to the "Free" list.

"Available" includes the Standby list and is just as ready for assignment to a new use as "Free" is, so if you have plenty of "Available" there is less need to worry about not much of it being "Free".

Even for "Available", the main advantage of having plenty of available memory is to support rapid startup of new programs, or new behavior in already-running programs. At such times you will see flurries of hard page faults - this is completely normal, indeed, unavoidable. If your workload doesn't do a lot of that then your system can be happy with a lower percentage of Available RAM.

And again I will mention: An SSD makes hard page faults go a lot faster than if they're going to a spinning disk. And they'll go faster still if it's an M.2 PCIe SSD. They're still much much slower than soft faults.

One more thing: You will often hear the claim that "you can never have enough RAM". Well, it is true that (barring some unusual circumstances) adding RAM to your system will never cause a performance problem. However you can most certainly spend too much money on RAM. There is a point of diminishing returns beyond which adding more RAM won't speed up your system noticeably. Where this point is depends on your workload and on various aspects of your hardware (particularly on whether you have an SSD or a spinning disk). As I believe I have made clear above, getting rid of your pagefile does not eliminate paging to/from disk, because mapped files still exist and are still read and written via paging. So getting rid of your pagefile (which you shouldn't do anyway) doesn't mean you can stop worrying about how fast your disk is.

#                  Further Readings

( Note the second: I realize that this is long. This is about as short as I can make it while at least attempting to answer most of the questions that commonly arise from shorter answers. For comparison, the Memory Management chapter of Windows Internals is about 200 pages, enough to make a decent-sized book all by itself. If you really want to learn this stuff, there is another book (that I recommend) called What Makes It Page? that goes into even more detail. It's just over 600 pages. As I mention above I will likely be editing this over the next few days, but don't expect it to get shorter! )
