```bash
#!/bin/bash

#? 'date' command can handle only one format: 'YYYY-mm-dd'
date1_as_text=$(echo "03/12/2024" | awk -F "/" '{print($3,"-",$2,"-",$1)}')
date2_as_text=$(echo "3/12/2024" | awk -F "/" '{print($3,"-",$2,"-",$1)}')

#? Transform our dates as text into Epoch time format
date1=$(date --date="$date1_as_text" +%s)
date2=$(date --date="$date2_as_text" +%s)

echo "Date1: $date1"
echo "Date2: $date2"

#? We must use this '(())' for bash to work with variables as a numbers ('9' < '1111'). If use '[[]]' it will work with them as a text ('9' > '11111')
if (( "$date1" == "$date2" )); then
    echo "Date1 is same as Date2"
elif (( "$date1" < "$date2" )); then
    echo "Date1 is older than Date2"
elif (( "$date1" > "$date2" )); then
    echo "Date1 is newer than Date2"
fi
```