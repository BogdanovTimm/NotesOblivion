#              What it is

You may do something after ansible playbook has finished it execution, but only if some task called it after successfully end their work:

```yaml
    - name: Task name
      copy:
        src: /home/usename/filename.txt
        dest: /var/www/html/index.html
        mode: 777
      notify: Handler name
  
  handlers:
    - name: Handler name
      service: 
        name: nginx
        state: restarted
```