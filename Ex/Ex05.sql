-- JOIN문: EQUI Join
-- c11 r107
select  *
from employees;

-- c04 r27
select  *
from departments;

-- c(11+4=)15 r(107*27=))2889
select  *
from employees, departments;

-- c r106(107)
select  employee_id,
        first_name,
        salary,
        em.department_id,
        de.department_id,
        department_name
from employees em, departments de
where em.department_id = de.department_id;

-- 모든 직원이름(employees), 부서명(departments), 업무명(jobs) 출력
select  first_name,
        de.department_id,
        department_name,
        jb.job_id,
        job_title
from employees em, departments de, jobs jb
where em.department_id = de.department_id
and   em.job_id = jb.job_id
and   em.salary < 30000;

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