-- CASE~END문
select  employee_id,
        first_name,
        job_id,
        salary,
        case    when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
                when job_id = 'SA_REP' then salary + salary * 0.2
                when job_id = 'ST_CLERK' then salary + salary * 0.3
                else salary
        end bonus
from employees;

-- DECODE() 함수: 조건식 넣을 수 없음
select  employee_id,
        first_name,
        job_id,
        salary,
        decode(job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                'SA_REP', salary + salary * 0.2,
                'ST_CLERK', salary + salary * 0.3,
        salary) realSalary
from employees;

-- 직원의 이름, 부서, 팀 출럭, 팀은 코드로 결정: default 팀없음
-- 부서코드가 10~50이면 'A-TEAM', 60~100이면 'B-TEAM', 110~150이면 'C-TEAM'
select  first_name,
        department_id,
        case    when department_id between 10 and 50 then 'A-TEAM'
                when department_id between 60 and 100 then 'B-TEAM'
                when department_id between 110 and 150 then 'C-TEAM'
                else '팀없음'
        end team
from employees;