# Change permission

```
chomod ugo+rwx fileName.txt
```

- `u` - owner
- `g` - group of a file
- `o` - all other users
- `+` or `-` - allow or restrict
- `r` - read
- `w` - write
- `x` - run

###  SUID

```
chomod u+s fileName.txt
```

When user run file - it gets permissions of a user that created this file.

### SGID

```
chomod g+s fileName.txt
```

When user run file - it gets permissions of a a group of that file.

### Sticky Bit
```
chmod +t fileName.txt
```

Only user that created a file or a folder can delete it (also, root can do this).

# Change owner of a file

```
chown nameOfOwningUser:nameOfOwningGroup filename.txt
```

# Change owner of a folder and all files within

```
chown -R nameOfOwningUser:nameOfOwningGroup folderName
```

# Default Permissions

`umask u+rwxs`