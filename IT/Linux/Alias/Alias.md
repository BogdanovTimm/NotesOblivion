# Create Alias

1. `nano .bashrc` - opens file with all aliases
2. `alias aliasName="ls -l"` - write this line and save file
3. If there is no such lines in a file - add them :
```bash
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi
```
4. `source .bashrc`

