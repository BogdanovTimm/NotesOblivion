#                  What it is?

Flock is a special way to enshure that your script will not be called again, if it is already runs.










#                  Use










##                 Outside script

- `flock /path/to/lock/file.lock /path/to/script` - if script will be called again - it will wait till previous ends and starts again
- `flock -n /path/to/lock/file.lock /path/to/script` - if script will be called again - it will fail and will not be started after previous ends










##                 Inside script









###                Just fail all duplicate calls

```Bash
#!/bin/bash

main_funciton() {
    echo "Script is running..."
    sleep 60
    echo "Script is done"
}

fail_funciton() {
    echo "There is another instance running, exiting"
    exit 1
}

( flock -n 100 || fail_funciton ; main_funciton ) 100>./lock_file.lock # 100 = number of File Descriptor
```










###                Run all duplicate calls one by one

```Bash
#!/bin/bash

main_funciton() {
    echo "Script is running..."
    sleep 60
    echo "Script is done"
}

fail_funciton() {
    echo "There is another instance running, exiting"
    exit 1
}

( flock 100 || fail_funciton ; main_funciton ) 100>./lock_file.lock # 100 = number of File Descriptor
```