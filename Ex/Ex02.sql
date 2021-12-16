select  *
from employees;

-- 단일행함수: 문자함수
select  email,
        initcap(email),
        department_id
from employees
where department_id = 100;

select  first_name,
        lower(first_name),
        upper(first_name)
from employees
where department_id = 100;

select  first_name,
        substr(first_name,1,3),
        substr(first_name,-3,2)
from employees
where department_id = 100;

select  first_name,
        lpad(first_name,10,'*'),
        rpad(first_name,10,'*')
from employees;

select  first_name,
        replace(first_name,'a','*')
from employees
where department_id = 100;

select  first_name,
        replace(first_name,'a','*'),
        replace(first_name, substr(first_name,2,3),'***')
from employees
where department_id = 100;

-- 숫자함수
select  round(123.345,2) "r2",
        round(123.456,0) "r0",
        round(123.456,-1) "r-1"
from dual;

select  trunc(123.346,2) "r2",
        trunc(123.456,0) "r0",
        trunc(123.456,-1) "r-1"
from dual;

-- 날짜함수
select  sysdate
from dual;

select  sysdate,
        hire_date,
        trunc(months_between(sysdate, hire_date),0),
        round(months_between(sysdate, hire_date),0)
from employees
where department_id = 100;

-- 변환함수
select  first_name,
        salary,
        salary*12,
        to_char(salary*12, '$99999999'),
        to_char(salary*12, '$09999999'),
        to_char(salary*12, '$99999,99')
from employees
where department_id = 100;

select  sysdate,
        to_char(sysdate, 'YYYY'),        
        to_char(sysdate, 'YYYY-MM-DD-DY HH24:MI:SS')
from dual;

select  sysdate,
        to_char(sysdate, 'DD'),
        hire_date,
        to_char(hire_date, 'MM'),
        to_char(hire_date, 'DAY')
from employees;

-- 일반함수
select  first_name,
        commission_pct,
        nvl(commission_pct,0)
from employees;

select  first_name,
        commission_pct,
        nvl2(commission_pct,100,0)
from employees;