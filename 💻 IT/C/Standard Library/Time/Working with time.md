# time.h

- `time(time_t* t);` - gives current time in `time_t`
- `mktime()` - It gets time as `tm` and returns the time as a `time_t`. `time_t` represents the same calendar times as struct tm but is defined to be an arithmetic type, more suited to compute with such types. It operates on a linear time scale. A `time_t` value of 0 at the beginning of `time_t` is called the epochC in the C jargon. Often this corresponds to the beginning of Jan 1, 1970. The granularity of time_t is usually to the second, but nothing guarantees that. Sometimes processor hardware has special registers for clocks that obey a different granularity. 
- `difftime()` - translates the difference between two `time_t` values into seconds that are represented as a `double` value. 
- `asctime_s()` - converts from `tm` to `char[]`
- `strftime(array_to_write_in, format_as_string, tim_as_struct_tm)` - converts from `tm` to `char[]` with format specifiers
- `timespec_get()` - returns `timespec` if you need prescision more than a 1 second
- `ctime_s()` - converts from `time_t` into `char[]`
- `gmtime_s()` - converts from `time_t` into `tm` as global time
- `localtime_s()` - converts from `time_t` into `tm` as local time
- `clock()` - returns `clock_t` - It is an arithmetic time that gives the processor time in CLOCKS_PER_SEC units per second. 

## struct `timespec`

Consists of :
- `time_t` - granularity in seconds
- `long` - nanosecond prescision

## struct `tm`

As we know, struct tm structures a calendar time mainly as you would expect. It has hierarchical date members such as tm_year for the year, tm_mon for the month, and so on, down to the granularity of a second. 
It has one pitfall, though: how the members are counted. All but one start with 0: 
- tm_mon set to 0 stands for January
- tm_wday 0 stands for Sunday. 
- tm_mday starts counting days in the month at 1. 
- tm_year must add 1900 to get the year in the Gregorian calendar. Years represented that way should be between Gregorian years 0 and 9999.
- tm_sec is in the range from 0 to 60, inclusive. The latter is for the rare occasion of leap seconds. 
- tm_wday for the week day
- tm_yday for the day in the year
- tm_isdst is a flag that informs us whether a date is considered to be in DST for the local time zone. The consistency of all these members can
