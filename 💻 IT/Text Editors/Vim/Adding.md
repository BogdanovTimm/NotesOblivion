#                  Add at a start of evey line

1. `Shift + ;`
2. `%s/^/Text to add`

##                  Add every X line

1. `Shift +;`
2. `:%s/\v(.*\n){2}/&Text to add` - adds 'Text to add' every 2d line