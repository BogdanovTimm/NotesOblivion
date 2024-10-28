#              Save output from executing a command on Slave PC as a variable

```yaml
      - name: While-loop
        shell: echo "Lorem Ipsum"
        #? Saves output from 'shell' as a variable
        register: output_from_shell_as_variable
```







#           Use variable

```yaml
  - name: Task name
	copy:
	  src: "{{ variable1 }}"
	  dest: /home/usename/filename.txt
	  mode: 777
	notify: Restart Nginx
```