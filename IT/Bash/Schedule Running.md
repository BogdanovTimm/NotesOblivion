# Run Script multiple times

1. `crontab -e` - opens configuration for crontab
2. Within opened by previous command file:
```
# '*' meant 'every'
# minutes  hours  day_of_month  month  day_of_week  command
  59       23     *             *      5            /usr/local/bin/scriptname.sh
```

# Run Script later once

`at 22:00 081623 -f /path/to/script.sh` - it will run script.sh at 22:00 of 16th august 2023

`atq` - see queue of commands to run later. Also it shows id of a command

`atrm 4` - deletes command whichi id that `atq` shows equal to 4