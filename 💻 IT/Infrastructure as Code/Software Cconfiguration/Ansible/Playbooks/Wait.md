# Wait till server restart

```yaml
- name: Task name
  shell: sleep 3 && reboot now
  async: 1
  poll: 0

- name:
  wait_for:
    host: PC_name_from_hosts_file
    state: started
    delay: 5
    timeout: 40
    delegate_to: 222.222.222.3
```