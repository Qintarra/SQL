-- 1. All employees whose salaries are in the database, along with their salaries.  
select employee_name, monthly_salary 
from employees 
join employee_salary on employee_salary.employee_id = employees.id
join salary on employee_salary.salary_id = salary.id;

-- 2. All employees whose salary is less than 2000.  
select employee_name, monthly_salary 
from employees 
join employee_salary on employee_salary.employee_id = employees.id
join salary on employee_salary.salary_id = salary.id
where monthly_salary < 2000;

-- 3. All salary positions, but no employee has been assigned to them. (There is a salary, but it is not clear who receives it).  
select employee_name, monthly_salary 
from employees 
right join employee_salary on employee_salary.employee_id = employees.id
right join salary on employee_salary.salary_id = salary.id;

-- 4. All salary positions less than 2000 but no employee has been assigned to them. (There is a salary, but it is not clear who receives it).  
select employee_name, monthly_salary 
from employees 
right join employee_salary on employee_salary.employee_id = employees.id
right join salary on employee_salary.salary_id = salary.id;
where monthly_salary < 2000;

-- 5. All employees who have not received a salary.  
select employee_name, salary_id 
from employees
left join employee_salary on employee_salary.employee_id = employees.id
where salary_id is null;

-- 6. All employees with their job titles.  
select employee_name, role_name
from employees
join roles_employee on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id;

-- 7. Names and titles of Java developers only.  
select employee_name, role_name
from employees
join roles_employee on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id
where role_name like '%Java dev%';

-- 8. Names and titles of only Python developers. 
select employee_name, role_name
from employees
join roles_employee on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id
where role_name like '%Python dev%';
 
-- 9. Names and position of all QA engineers.  
select employee_name, role_name
from employees
join roles_employee on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id
where role_name like '%QA%';

-- 10. Names and position of manual QA engineers.  
select employee_name, role_name
from employees
join roles_employee on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
where role_name like '%Manual QA%';

-- 11. Names and position of QA automators.  
select employee_name, role_name
from employees
join roles_employee on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
where role_name like '%Auto%QA%';

-- 12. Names and salaries of junior specialists.  
select employee_name, monthly_salary, role_name 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like '%Jun%';

-- 13. Names and salaries of middle specialists.  
select employee_name, monthly_salary, role_name 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like '%Mid%';

-- 14. Names and salaries of senior specialists.  
select employee_name, monthly_salary, role_name 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like '%Senior%';
 
-- 15. Salaries of Java developers.   
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id;

-- 16. Python developer salaries.  
select role_name, monthly_salary 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where roles.role_name like '%Python dev%';

-- 17. Names and salaries of junior Python developers.  
select employee_name, monthly_salary, role_name 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where roles.role_name like '%Junior Python%';

-- 18. Names and salaries of middle JS developers.  
select employee_name, monthly_salary, role_name 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where roles.role_name like '%Middle JavaScript dev%';

-- 19. Names and salaries of senior Java developers.  
select employee_name, monthly_salary, role_name 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where roles.role_name like '%Middle JavaScript dev%';

-- 20. Salaries of junior QA engineers. 
select monthly_salary, role_name
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like 'Junior%QA%';
 
-- 21. Average salary of all junior specialists.  
select avg(monthly_salary) as avg_jun_salary
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like 'Jun%';

-- 22. Sum of salaries of JS developers.  
select sum(monthly_salary) as sum_JavaScript_devs_salary
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like '%JavaScript dev%';

-- 23. Minimum salary of QA engineers. 
select min(monthly_salary) as min_qa_salary
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like '%QA%';
 
-- 24. Maximum salary of QA engineers.  
select max(monthly_salary) as max_qa_salary
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like '%QA%';

-- 25. Number of QA engineers.  
select count(role_name) as qa_count
from roles_employee 
join roles on roles_employee.role_id = roles.id
where role_name like '%QA%';

-- 26. Number of middle specialists.  
select count(role_name) as mid_count
from roles_employee 
join roles on roles_employee.role_id = roles.id
where role_name like '%Mid%';

-- 27. Number of developers.  
select count(role_name) as devs_count
from roles_employee 
join roles on roles_employee.role_id = roles.id
where role_name like '%dev%';

-- 28. Sum of the developers' salaries.  
select sum(monthly_salary) as sum_devs_salary
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
where role_name like '%dev%';

-- 29. Names, positions and salaries of all specialists in ascending order.  
select employee_name, role_name, monthly_salary 
from roles_employee 
join employees on roles_employee.employee_id = employees.id
join roles on roles_employee.role_id = roles.id 
join employee_salary on employee_salary.employee_id = employees.id
join salary on salary_id = salary.id
order by monthly_salary;
