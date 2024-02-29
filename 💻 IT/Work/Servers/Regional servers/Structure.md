```RUBY
/
sas/
   '
   'region-errors.log    #file with errors from /sas/isystemf94/logs
   '
   'isystemf94/
   '          '
   '          'logs_data/    #SAS tables for logs
   '          '
   '          'logs/  #logs for ^letters_from_morning_ERR.error^
   '
   'sheduler/
            '
            'sheduler.sh   #main script
            '
            'start_process94.sh   #runs ^letters_from_morning_ERR^.{done | error |working}
            '
            'spool/
                  '
                  status/   #^letters_from_morning_ERR^.{done | error |working}
```