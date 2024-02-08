#                  `find` vs `locale`

Summary:
- always use `find`

`locale` - checks table of files. It is faster, but if this table was not updated since file you want to find was created - it will not find it!
`find` - works slower, but will find your file anyway









#                  Using `locate`

`locate %file_name%`









#                  Using `find`

Code below:
- `-type %f%` - chooses whats to find - in the case of `f` - finds only files
- `printf '%f.%TY%Tm%Td\n'` - prints files as 'Filename.YearMonthDay' and place a carriage return

```BASH
find /folder/in/which/to/find    \
    -type f                      \
    -printf '%f.%TY%Tm%Td\n'     \
```
