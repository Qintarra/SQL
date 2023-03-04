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

11. Insert 40 rows into the roles_employee table  

###Second part

Write a query to:  
1. Display all employees whose salaries are in the database, along with their salaries.  
2. Display all employees whose salary is less than 2000.  
3. Display all salary positions, but no employee has been assigned to them. (There is a salary, but it is not clear who receives it).  
4. Display all salary positions less than 2000 but no employee has been assigned to them. (There is a salary, but it is not clear who receives it).  
5. Find all employees who have not received a salary.  
6. Display all employees with their job titles.  
7. Display names and titles of Java developers only.  
8. Display the names and titles of only Python developers.  
9. Display the names and position of all QA engineers.  
10. Display the names and position of manual QA engineers.  
11. Display the names and position of QA automators.  
12. Display the names and salaries of junior specialists.  
13. Display names and salaries of middle specialists.  
14. Display the names and salaries of senior specialists.  
15. Display salaries of Java developers.   
16. Display Python developer salaries.  
17. Display names and salaries of junior Python developers.  
18. Display names and salaries of middle JS developers.  
19. Display the names and salaries of senior Java developers.  
20. Display salaries of junior QA engineers.  
21. Display the average salary of all junior specialists.  
22. Display the amount of salaries of JS developers.  
23. Display the minimum salary of QA engineers.  
24. Display the maximum salary of QA engineers.  
25. Display the number of QA engineers.  
26. Display the number of middle specialists.  
27. Display the number of developers.  
28. Display the fund (amount) of the developers' salaries.  
29. Display the names, positions and salaries of all specialists in ascending order.  
30. Display the names, positions and salary of all specialists in ascending order from specialists whose salary is from 1700 to 2300.    
31. Display the names, positions and salary of all specialists in ascending order from specialists whose salary is less than 2300.  
32. Display the names, positions and salary of all specialists in ascending order for specialists whose salary is equal to 1100, 1500, 2000.  