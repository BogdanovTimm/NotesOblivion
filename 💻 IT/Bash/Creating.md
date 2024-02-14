1. `nano %script_name%.sh` - creates a file
2. `sudo chmod +x %script_name%.sh` - make it executable
3. Open it in a text editor and add `#!/bin/bash` to the 1st line
4. `set -eu # '-e' exit if error in any command. '-u' - error if variable that equal to null is used` - write this into script