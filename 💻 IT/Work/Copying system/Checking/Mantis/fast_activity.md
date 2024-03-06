#                  How it look sin Mantis

```
Суть:        0080627: sasetl1: mr04 fast_activity ERROR!

Подробности: /sas/dwh/mr04/logs/fast_activity-240306-133452.log
            ERROR: File ODS_04.CDTL_35478.DATA does not exist.
```









#                  What it is?

Sometimes this process is started too late and then the tabl eit needs is deleted.

#                  Fix

Actually, it is not a serious error, so we could ignore that, but lsf-jobs that need that `fast_activity` lsf-job are important.
So, you need to start lsf-jobs that need it.

1. Go to a server
2. `sudo -iu sas`
3. `/sas/home/apchuykin/viewpend.sh` - gives you jobs that are not started yet
4. `bjdepinfo -l ^id_from_viewpend^` - check whether this process depend on `fast_activity` lsf-job:
    - If it depends: `bmod -wn ^id_from_viewpend^`
    - If not depends: do nothing, check another one