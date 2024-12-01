# What it is

This command allows you to find files or folders

# Command



`find %/etc% [параметры] %-name% %filename*% [действие]`

**Папка** - каталог в котором будем искать

**Параметры** - дополнительные параметры, например, глубина поиска, и т д

**Критерий** - по какому критерию будем искать: имя, дата создания, права, владелец и т д.

**Шаблон** - непосредственно значение по которому будем отбирать файлы.

## Основные параметры команды find

Я не буду перечислять здесь все параметры, рассмотрим только самые полезные.

- `-P` - никогда не открывать символические ссылки.
- `-L` - получает информацию о файлах по символическим ссылкам. Важно для дальнейшей обработки, чтобы обрабатывалась не ссылка, а сам файл.
- `-maxdepth 1` - максимальная глубина поиска по подкаталогам, для поиска только в текущем каталоге установите 1.
- `-depth` - искать сначала в текущем каталоге, а потом в подкаталогах.
- `-mount` искать файлы только в этой файловой системе.
- `-version` - показать версию утилиты find.
- `-print` - выводить полные имена файлов.
- `-type f` - искать только файлы.
- `-type d` - поиск папки в Linux.

## Критерии

Критериев у команды find в Linux очень много, и мы опять же рассмотрим только основные.

- `-name` - поиск файлов по имени.
- `-perm` - поиск файлов в Linux по режиму доступа.
- `-user` - поиск файлов по владельцу.
- `-group` - поиск по группе.
- `-mtime` - поиск по времени модификации файла.
- `-atime` - поиск файлов по дате последнего чтения.
- `-nogroup` - поиск файлов, не принадлежащих ни одной группе.
- `-nouser` - поиск файлов без владельцев.
- `-newer` - найти файлы новее чем указанный.
- `-size` - поиск файлов в Linux по их размеру.