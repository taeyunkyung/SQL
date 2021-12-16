select  *
from employees;

-- 그룹함수: 1개의 row에 표현할 수 없음
select  first_name, avg(salary)
from employees;

-- avg(), count(), sum(), max()/min()
select round(avg(salary))
from employees;

select  count(*),
        count(commission_pct),
        count(department_id)
from employees;

select  count(*)
from employees
where salary > 16000;

select  count(*)
from employees
where department_id = 100;

select  count(*),
        sum(salary)
from employees;

select  sum(salary),
        count(*),
        avg(salary)
from employees
where salary > 16000;

select  count(*),
        sum(salary),
        round(sum(salary)/count(*)) as "avg",
        round(avg(nvl(salary,0)),0)
from employees;

select  count(*),
        max(salary),
        min(salary)
from employees;

-- GROUP BY절
select  department_id,
        salary
from employees
order by department_id asc;

select  department_id,
        round(avg(salary),0)
from employees
group by department_id
order by department_id asc;

select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id;