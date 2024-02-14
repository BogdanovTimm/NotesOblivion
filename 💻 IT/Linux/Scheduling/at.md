# Run Program or Script later once

## Way 1

`at 22:00 081623 -f /path/to/script.sh` - it will run script.sh at 22:00 of 16th august 2023

## Way 2

`echo "" | at 23:59`

`atq` - see queue of commands to run later. Also it shows id of a command

`atrm 4` - deletes command which id that `atq` shows equal to 4

# Installation

`sudo apt install at`