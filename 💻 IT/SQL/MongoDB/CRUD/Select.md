#                  Select

##                 Select All

`db.^table_name^.find()` - it will give you only a page of all rows from a table. 

`it` - go to the next page of rows

##                 Select where

`db.^table_name^.find({"^column_name^.^sub_column^": "^value^"})` - 1find in both field, or field's arrays

`db.^table_name^.find({"^column_name^": {$in: ["^value1^", "value2"]}})`

`db.^table_name^.find({"^column_name^": {$lte: ^5^}})`

`db.^table_name^.find({"^column_name^": {$elemMatch: { "^array_column^": {$gte: "^5^"}, "^array_column2^": "value2"}}})` - find within arrays