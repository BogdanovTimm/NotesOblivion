#                  For-loops

```yaml
  - name: Task name
	apt:
	  #? [item] is a scpeical variable name, that will be replaced by all values under a 'loop' keyword
	  name: "{{ item }}"
	  state: latest
	loop:
	  - nginx
	  - nano
	  - less
```









#                While-loops

```yaml
  - name: While-loop
	shell: echo "Lorem Ipsum"
	#? Saves output from 'shell' as a variable
	register: output_from_shell_as_variable
	#? While-loop --v
	#? Try every 3 seconds
	delay: 3
	#? After which amount of tries to exit with error code
	retries: 10
	#? When to stop
	until: output_from_shell_as_variable.stdout.find("Lorem Ipsum") == false
	#? While-loop --^
```