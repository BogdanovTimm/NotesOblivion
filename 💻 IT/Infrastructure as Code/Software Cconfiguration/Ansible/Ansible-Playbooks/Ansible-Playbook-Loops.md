#                  For-loops

Types of Ansible-For-Loops:
* `with_xLOOKUPx` - something like `for (lookup('xTYPEx', 'xOBJECTx'))`:
    * `with_items` - do implicit single-level flattering
* `loop` - same as `with_list`

```yaml
  - name: Task name
	apt:
	  name: "{{ item.name }}" # [item] is scpeical variable, that will be replaced by all values under [loop]
	  state: latest
	loop:
	  - { name: 'emacs', description: 'Best IDE'           }
	  - { name: 'nano' , description: 'Lightweight Notepad'}
```









#                While-loops

```yaml
  - name: While-loop
	shell: echo "Lorem Ipsum"
	register: output_from_shell_as_variable # Saves output from 'shell' as a variable
	# v-------------------------------- While-loop
	delay: 3                                # Try every 3 seconds
	retries: 10                             # After which amount of tries to exit with error code
	until: output_from_shell_as_variable.stdout.find("Lorem Ipsum") == false # When to stop
	# ^-------------------------------- While-loop
```