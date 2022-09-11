# Database design and SQL (DDL)

## Task  

Create a database scheme for the domain (see description). The BD scheme must correspond to at least the third normal form (3NF).

DB should contain at least 7 tables with primary and foreign keys, unique, not null attributes where it is suitable.

### Restrictions for creating table statements
- Do not use ALTER operations 
- Don’t use cascading deletion from tables (is forbidden).
- Please use only simple primary and foreign keys (single column/attribute).
- Do not use IF NOT EXISTS statement.
- Do not use `` to escape a table name or column name.
- Don’t use digits in table names or column names.
- Use only  CREATE TABLE statements (CREATE index, etc. are forbidden) 

### Domain description   

- The company employees carry out projects (project data: name, date of creation, status open/closed, date of closure).   
- An employee can carry out several projects, on different projects his position may differ.  
