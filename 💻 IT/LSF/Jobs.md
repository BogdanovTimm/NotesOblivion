#                  Add new job

`bsub -G ^user_group^ -g ^/job/group^ -b ^5:00 (start time)^ -t ^11:12:20:30 ((November, 12th, 20:30) terminate time)^ -J ^job_name_alias^ ^job_name^ ^command or script^`

`bsub -w "done([other_job])" -J "[new_job_name]" [command_to_run]`









#                  Change existing job

`bmod -g ^/new/job/group^ -v ^new swap limit^ ^existing_job_name^`









#                  Show jobs

`bjobs` - shows all jobs
`bjobs -r` - shows only running jobs
`bjobs -ls` - shows detailed information about only stopped jobs
`bjobs -l ^job_id^`- shows detailed information about job
`bjobs -w ^job_id^` - show detailed information about job 2 - **use it!**

##                 Dependencies

`bjdepinfo -l ^job_id^` - show detailed information about job's dependencies
`bjdepinfo -l ^job_id^ | gawk '$3 != "DONE" {print $0}'`

##                                     See output from the job

`bpeek ^job_id^`









##                                     Shows lsf's log for a job

`bhist -T ^14:00,14:30 (from, to)^ ^job_id^` - shows all logs from 14:00 to 14:30







##                                     Show resource usage

`blimits`





#                  Stop and resume job

##                 Stop

`bstop -g ^/job/group^ ^job_id^`
`bstop -g ^/job/group^ 0` - stop all jobs in a group

##                 Resume

`bresume -g ^/job/group^ ^job_id^`
`bresume -g ^/job/group^ 0` - resume all jobs in a group









#                 Restart

`brequeue -r ^job_id^` - use it!









#                  Terminate running job

`bkill -g ^/job/group^ ^job_id^`
`bkill -r -g ^/job/group^ ^job_id^` - force terminate
`bkill -g ^/job/group^ ^job_id^` - terminate all jobs in the group

##                 Delete job group

`bgdel ^/job/group^`