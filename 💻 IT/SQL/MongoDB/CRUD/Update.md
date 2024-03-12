#                  Update 1 row (Thread safe)

```JSON
db.^table_name^.replaceOne({
    query: { // WHERE
        "id": ObjectId("123")
    },
    update: {
        $inc:{"^column1^": "^value1^"},
        $set:{"^column1^": "^value1^"}, // Update columns
        $push: {"^array_column2^": "^value2^"}
    },
    upsert: true,
    new: true // Returns updated row instead of a started one
})
```









#                  Update 1 row (not thread-safe)

```JSON
db.^table_name^.replaceOne(
    {"id": ObjectId("123")}, // WHERE
    {$set:{"^column1^": "^value1^"}, // Update columns
     $push: {"^array_column2^": "^value2^"} // Update arrays
    },
    {upsert:true} // Create if not exists
)
```









#                  Update many rows (Non-thread safe)

```
db.^table_name^.updateMany(
    {"id": ObjectId("123")}, // WHERE
    {$set:{"^column1^": "^value1^"}, // Update columns
     $push: {"^array_column2^": "^value2^"} // Update arrays
    },
    {upsert:true} // Create if not exists
)
```