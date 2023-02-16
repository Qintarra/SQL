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

