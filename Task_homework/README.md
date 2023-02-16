## SQL Task

### First part

**employees table**  

1. Create the employees table  
- id. Serial, primary key  
- employee_name. Varchar(50), not null  

2. Insert 70 rows into the employee table.  

**salary table**  

3. Create salary table  
- id. Serial, primary key  
- monthly_salary. Int, not null  

4. Insert 15 rows into the salary table:  
- 1100
- 1200
- 1300
- 1400
- 1500
- 1600
- 1700
- 1800
- 1900
- 2000
- 2100
- 2200
- 2300
- 2400
- 2500

**employee_salary table**  

5. Create employee_salary table  
- id. Serial, primary key  
- employee_id. Int, not null, unique  
- salary_id. Int, not null  

6. Insert 40 rows into the employee_salary table  
Insert a non-existent employee_id in 10 rows out of 40  

**roles table**  

7. Create table roles
- id. Serial, primary key
- role_name. Int, not null, unique  

8. Change column type role_name from int to varchar(30)  

9. Insert 20 rows into the roles table  

|id	|role_name                     |
|---|------------------------------|
|1	|Junior Python developer       |
|2	|Middle Python developer       |
|3	|Senior Python developer       |
|4	|Junior Java developer         |
|5	|Middle Java developer         |
|6	|Senior Java developer         |
|7	|Junior JavaScript developer   |
|8	|Middle JavaScript developer   |
|9	|Senior JavaScript developer   | 
|10	|Junior Manual QA engineer     |
|11	|Middle Manual QA engineer     |
|12	|Senior Manual QA engineer     |
|13	|Project Manager               |
|14	|Designer                      |
|15	|HR                            |
|16	|CEO                           |
|17	|Sales manager                 |
|18	|Junior Automation QA engineer |
|19	|Middle Automation QA engineer |
|20	|Senior Automation QA engineer |

**roles_employee table**

10. Create table roles_employee  
- id. Serial, primary key,  
- employee_id. Int, not null, unique (foreign key for employees table, id field)  
- role_id. Int, not null (foreign key for roles table, id field)  
