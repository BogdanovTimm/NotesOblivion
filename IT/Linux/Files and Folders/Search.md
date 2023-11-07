# Find file by name

`find directoryInWhichToSearch -name filename.txt`

# Do something with finded files

`find directoryInWhichToSearch -name filename.txt -exec commandToRunOnEveryFindedFile {} \;`
where:
- `-exec` - needs to 