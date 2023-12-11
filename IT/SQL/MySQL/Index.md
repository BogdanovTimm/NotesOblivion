Index is the special column for more fast work with the table.

Creating a new index:

```mysql
ALTER TABLE
	table1
ADD INDEX
	new_index1 (column1, column2)
; 
```

you should think carefully about which column to list first, which column to list second, and so on, to help make the index as useful as possible. Keep in mind, however, that there is nothing stopping you from building multiple indexes using the same set of columns but in a different order if you feel that it is needed to ensure adequate response time. 

If, after creating an index, you decide that the index is not proving useful, you can remove it via the following:

```mysql
ALTER TABLE
    table1
DROP INDEX
    existing_index1
;
```

# When to use

Make sure all primary key columns are indexed (most servers automatically create unique indexes when you create primary key constraints). For multicolumn primary keys, consider building additional indexes on a subset of the primary key columns or on all the primary key columns but in a different order than the primary key constraint definition.

Build indexes on all columns that are referenced in foreign key constraints. Keep in mind that the server checks to make sure there are no child rows when a parent is deleted, so it must issue a query to search for a particular value in the column. If there’s no index on the column, the entire table must be scanned. 

Index any columns that will frequently be used to retrieve data. Most date columns are good candidates, along with short (2- to 50-character) string columns. 

# Unique index

You can enforce a rule against duplicate values by creating a unique index on the customer.email column.

A unique index plays multiple roles; along with providing all the benefits of a regular index, it also serves as a mechanism for disallowing duplicate values in the indexed column. Whenever a row is inserted or when the indexed column is modified, the database server checks the unique index to see whether the value already exists in another row in the table. Here’s how you would create a unique index on the customer.email column: 

With the index in place, you will receive an error if you try to add a new customer with an email address that already exists: 

You should not build unique indexes on your primary key column(s), since the server already checks uniqueness for primary key values. You may, however, create more than one unique index on the same table if you feel that it is warranted. 

# Types of indexes

## B-Tree index

All the indexes shown thus far are balanced-tree indexes, which are more commonly known as B-tree indexes. MySQL, Oracle Database, and SQL Server all default to B-tree indexing, so you will get a B-tree index unless you explicitly ask for another type. As you might expect, B-tree indexes are organized as trees, with one or more levels of branch nodes leading to a single level of leaf nodes. Branch nodes are used for navigating the tree, while leaf nodes hold the actual values and location information.

## Bitmap index

For columns that contain only a small number of values across a large number of rows (known as low-cardinality data), a different indexing strategy is needed. To handle this situation more efficiently, Oracle Database includes bitmap indexes, which generate a bitmap for each value stored in the column. If you were to build a bitmap index on the customer.active column, the index would maintain two bitmaps: one for the value 0 and another for the value 1. When you write a query to retrieve all inactive customers, the database server can traverse the 0 bitmap and quickly retrieve the desired rows. 

## Text index

If your database stores documents, you may need to allow users to search for words or phrases in the documents. You certainly don’t want the server to peruse each document and scan for the desired text each time a search is requested, but traditional indexing strategies don’t work for this situation. To handle this situation, MySQL, SQL Server, and Oracle Database include specialized indexing and search mechanisms for documents; both SQL Server and MySQL include what they call full-text indexes, and Oracle Database includes a powerful set of tools known as Oracle Text. Document searches are specialized enough that it is not practical to show an example, but it is useful to at least know what is available. 

# Cons of indexes

herefore, every time a row is added to or removed from a table, all indexes on that table must be modified. When a row is updated, any indexes on the column or columns that were affected need to be modified as well. Therefore, the more indexes you have, the more work the server needs to do to keep all schema objects up-to-date, which tends to slow things down.

Indexes also require disk space as well as some amount of care from your administrators, so the best strategy is to add an index when a clear need arises. If you need an index for only special purposes, such as a monthly maintenance routine, you can always add the index, run the routine, and then drop the index until you need it again. In the case of data warehouses, where indexes are crucial during business hours as users run reports and ad hoc queries but are problematic when data is being loaded into the warehouse overnight, it is a common practice to drop the indexes before data is loaded and then re-create them before the warehouse opens for business. 