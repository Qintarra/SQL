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
