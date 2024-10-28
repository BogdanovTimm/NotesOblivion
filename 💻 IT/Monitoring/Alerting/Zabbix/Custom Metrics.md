1. `/etc/zabbix/zabbix_agentd.d/new_metrics.conf` - open and add this text:
```conf
UserParameter=new.item.name[],echo "Hello World" | grep "World"
```
2. `zabbix_agentd -R userparameter_reload`
3. Go to zabbix website
4. Go to Hosts
5. Click to Items cell in the table on the right from the host you want to monitor
6. Create Item 
7. Type = Zabbix agent
8. Key = text from `/etc/zabbix/zabbix_agentd.d/new_metrics.conf`
9. 
10. Get value and test