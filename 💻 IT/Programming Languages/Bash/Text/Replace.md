# Replace every occurrence

```bash
awk 'gsub(/Text To Find/, "New text") {print($0)}' fileName.txt
```

# Replace only second occurrence in each line

```bash
sed 's/Text to Find/Text that will replace/2' fileName.txt
```

So, `abc Text to Find def Text to Find ghi Text to Find` becomes:
`abc Text to Find def Text that will replace ghi Text to Find`