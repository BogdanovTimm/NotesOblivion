#                 Logical OR

`db.^table_name^.find({$or [{"^column_name^": "^value^"}, {"^column_name2^": "^value2^"}]})`









#                 Logical AND

`db.^table_name^.find({$and [{"^column_name^": "^value^"}, {"^column_name2^": "^value2^"}]})`









#                 Both AND and OR

```JSON 
db.^table_name^.find({
    $and [
        {$or [
            {"^column_name^": "^value^"}, 
            {"^column_name2^": "^value2^"}
        ]},
        {$or [
            {"^column_name3^": "^value3^"}, 
            {"^column_name4^": "^value24"}
        ]} 
    ]
})
```