1. `netstat -anp | grep ":55551 " | grep -E "LISTEN|ESTABLISHED"` - give you PID
2. `ps -fp xPIDX`