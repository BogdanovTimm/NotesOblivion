`db.adminCommand({"serverStatus": 1})["tcmalloc"]`

//                  Output

``` JSON
{
    generic: {
        current_allocated_bytes: Long("213579061832")  // number of Bytes in all Heaps, used by TCMalloc
        heap_size: Long("253539381248")                // Bytes of RAM reserved for all Heaps by TCMalloc
    },
    tcmalloc: {
        pageheap_free_bytes             :  19430457344 // free RAM mapped pages in a Page Heap (in Bytes)
        pageheap_unmapped_bytes         :  18415243264 // free RAM unmapped pages in page Heap
        max_total_thread_cache_bytes    :   1073741824 // limit for sum of per-thread Heaps RAM
        current_total_thread_cache_bytes:     17590992 // RAM reserved by all per-thread Heaps
        thread_cache_free_bytes         :     17590992 // free RAM in thread Heap
        total_free_bytes                :   2114618808 // sum of free RAM in central Heap and in per-threaded ones, reserved by TCMalloc
        central_cache_free_bytes        :   2096949480 // free RAM in central Heap
        transfer_cache_free_bytes       :        78336 // RAM that are waiting to be transferred between the central cache and a thread cache
        aggressive_memory_decommit      :            0 // status of aggressive memory de-commit mode
        pageheap_committed_bytes        : 235124137984 //
        pageheap_scavenge_count         :       549283 //
        pageheap_commit_count           :      1526600 // committed RAM
        pageheap_total_commit_bytes     :   2033719296 // total committed RAM
        pageheap_decommit_count         :       549283 //
        pageheap_total_decommit_bytes   : 266909581312 // 
        pageheap_reserve_count          :       207019 // reserved RAM
        pageheap_total_reserve_bytes    : 253539381248 // same as [generic.heap_size]
        spinlock_total_delay_ns         : 399357867312 // spinlock delay time in Nano Seconds
        release_rate: 1,
        formattedString:
            'MALLOC:   213579062408 (203684.9 MiB) Bytes in use by application'
            'MALLOC: +  19430457344 ( 18530.3 MiB) Bytes in page heap freelist'
            'MALLOC: +   2096949480 (  1999.8 MiB) Bytes in central cache freelist'
            'MALLOC: +        78336 (     0.1 MiB) Bytes in transfer cache freelist'
            'MALLOC: +     17590416 (    16.8 MiB) Bytes in thread cache freelists'
            'MALLOC: +   1078198272 (  1028.2 MiB) Bytes in malloc metadata'
            'MALLOC: = 236202336256 (225260.1 MiB) Actual memory used (physical + swap)'
            'MALLOC: +  18415243264 ( 17562.1 MiB) Bytes released to OS (aka unmapped)'
            'MALLOC: = 254617579520 (242822.2 MiB) Virtual address space used'
            'MALLOC:        8903130 Spans in use'
            'MALLOC:             90 Thread heaps in use'
            'MALLOC:           4096 Tcmalloc page size'
            'Call ReleaseFreeMemory() to release freelist memory to the OS (via madvise()).'
            'Bytes released to the OS take up virtual address space but no physical memory.'
    }
}
```