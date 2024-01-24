#                  Using SQL

```SAS
proc sql; 
    select Subj, 
           Height, 
           Weight 
        from
            learn.health 
        where
            Height > 66
    ; 
quit; 
```