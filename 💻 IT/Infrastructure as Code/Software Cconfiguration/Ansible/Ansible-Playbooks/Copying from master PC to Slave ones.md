```yaml
- name: Task name
  copy:
    src: /home/usename/ansible/filename.txt
    dest: /var/www/html/index.html
    mode: 777 # Linux-File-Permissions
```