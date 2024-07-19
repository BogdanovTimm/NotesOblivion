#                  Encription

You can encrypt your password in a SAS by running this code:
```SAS
PROC PWENCODE IN = '<password>';
RUN;
```

After running this, it gives you something like `{sasenc}ACFD24061BF77D7D5362EE7C2D00D08B`