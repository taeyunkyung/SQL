-- 복습
select  first_name,
        salary,
        department_id
from employees;

select  first_name,
        salary,
        de.department_id,
        department_name
from employees em, departments de
where em.department_id = de.department_id;

select  count(*)
from employees em, departments de
where em.department_id = de.department_id;

select  em.first_name,
        de.department_id,
        de.department_name,
        jo.job_id,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id;

-- outer join > *left* outer join, 표준 쿼리
select  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id;

-- 오라클에서만 쓰는 표현
select  em.first_name,
        em.salary,
        de.department_id,
        de.department_name
from employees em, departments de
where em.department_id = de.department_id(+);

-- *right* outer join
select  em.first_name,
        em.salary,
        de.department_id,
        de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;

select  em.first_name,
        em.salary,
        de.department_id,
        de.department_name
from employees em, departments de
where em.department_id(+) = de.department_id;

-- right outer join -> left outer join
select  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
from departments de left outer join employees em
on em.department_id = de.department_id;

select  em.first_name,
        em.salary,
        de.department_id,
        de.department_name
from departments de, employees em
where em.department_id = de.department_id(+);

-- full outer join: (+)사용은 불가
select  em.first_name,
        de.department_id,
        de.department_name
from employees em full outer join departments de
on em.department_id = de.department_id;

-- self join
select  employee_id,
        first_name,
        phone_number,
        salary,
        manager_id
from employees;

select  em.employee_id,
        em.first_name,
        em.salary,
        em.phone_number,
        em.manager_id,
        ma.manager_id,
        ma.first_name as manager,
        ma.phone_number,
        ma.email
from employees em, employees ma
where em.manager_id = ma.employee_id;