#                  Create/Insert 1 row

`db.^table_name^.insertOne({^column_name^: "^Lorem Ipsum^", ^column2^: ^205^})`

#                  Create/Insert Many rows

```
db.^table_name^.insertMany([
    {^column_name^: "^Lorem Ipsum^", ^column2^: ^999^},
    {^column_name^: "^Dolor Set^", ^column2^: ^222^},
])
```