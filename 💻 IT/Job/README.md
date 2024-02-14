#                  Folder

`/sas/data1/dwh/scripts/src/arch`










#                  Structure

```

config.get_dirs.pl --> config.pm
config.get_files.pl
```

#                  Files

##                 `config.pm`

Creates:
- `num_days` variable - сколько дней будут храниться подневные таблички, не прописанные в шаблоне, при использовании config-auto
- `num_months` variable - сколько месяцев будут храниться помесячные таблички, не прописанные в шаблоне, при использовании config-auto
- `directory` array - `/sas/ppms/data/...`
- `scan` map - map of `.sas7bdat` files