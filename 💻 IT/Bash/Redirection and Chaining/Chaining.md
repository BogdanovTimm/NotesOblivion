# `&&`

`command1 && command2` - command2 will be called only if command1 was executed successfully

# `||`

`command1 || command2` - command2 will be called only if command1 was executed with an error


# `&& ||`

`command1 && command2 || command3` - if work as ternary-operator: if command1 was executed successfully - it calls command2. If command1 was executed with an error - it calls command3

### `()`

`(command1 && command2) || (command3 && command4)` - if command1 or command2 was executed with an error - it calls command3 and command4