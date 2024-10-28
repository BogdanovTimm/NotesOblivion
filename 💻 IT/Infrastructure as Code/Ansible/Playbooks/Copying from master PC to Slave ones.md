```yaml
      - name: Task name
        copy:
          src: /home/usename/ansible/filename.txt
          dest: /var/www/html/index.html
          #? Permissions
          mode: 777
```