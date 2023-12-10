# Run Program or Script multiple times

1. `crontab -e` - opens configuration for crontab
2. Within opened by previous command file:
```bash
# '*' meant 'every'
# '59' means 'right at 59', not `every 59`
# minutes  hours  day_of_month  month  day_of_week  command
  59       23     *             *      5            /usr/local/bin/scriptname.sh
```

# See scheduled commands for user

`crontab -lu userName`

# Restart Cron Service

`service crond restart`