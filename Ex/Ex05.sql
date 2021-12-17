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