-- 1. All employees whose salaries are in the database, along with their salaries.  
select employee_name, monthly_salary 
from employees 
join employee_salary on employee_salary.employee_id = employees.id
join salary on employee_salary.salary_id = salary.id;
