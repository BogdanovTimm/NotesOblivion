# Change permission

```
chomod ugo+rwxs
```

- `u` - owner
- `g` - group of a file
- `o` - all other users
- `+` or `-` - allow or restrict
- `r` - read
- `w` - write
- `x` - run
- `s` - whether it needs sudo

## suid

SUID: если установлен бит setuid, когда файл выполняется пользователем, процесс будет иметь те же права, что и владелец исполняемого файла.

## sgid

SGID: То же, что и выше, но наследует групповые привилегии файла при исполнении, а не привилегии пользователя. Аналогичным образом, когда вы создаете файл в каталоге, он наследует групповое владение каталогами.

## sticky bit

Sticky bit: Sticky bit использовался в исполняемых файлах Linux, чтобы они оставались в памяти больше времени после первоначального выполнения, надеясь, что они понадобятся в ближайшем будущем. Но в основном это касается папок, что подразумевает, что файл или папка, созданные в папке с поддержкой stickybit, могут быть удалены только владельцем. Очень хорошая реализация sticky-бита – это /tmp, где каждый пользователь имеет разрешение на запись, но удалить его могут только пользователи, владеющие файлом.

# Change owner of a file

```
chown nameOfOwningUser:nameOfOwningGroup filename.txt
```

# Change owner of a folder and all files within

```
chown -R nameOfOwningUser:nameOfOwningGroup folderName
```