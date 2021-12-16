-- 문제 1. 정렬: 입사일의 오름차순
-- 이름(first, last), 월급, 전화번호, 입사일 출력, 칼럼명 대체
select  first_name || ' ' || last_name as "이름",
        salary as "월급",
        phone_number as "전화번호",
        hire_date as "입사일"
from employees
order by hire_date asc;

-- 문제 2. 정렬: 월급의 내림차순(??)
-- 업무별로(??) 업무이름, 최고월급 출력
select  job_title as "업무이름",
        max_salary as "최고월급"
from jobs;

-- 문제 3. 담당매니저가 배정되어있으나 커미션비율이 없고 월급이 3000 초과인
-- 직원의 이름, 매니저 아이디, 커미션비율, 월급 출력
select  first_name || ' ' || last_name as "이름",
        manager_id as "매니저아이디",
        commission_pct as "커미션비율",
        salary as "월급"
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

-- 문제 4. 정렬: 최고월급의 내림차순
-- 최고월급이 10000 이상인 업무의 이름, 최고월급 출력
select  job_title as "업무명",
        max_salary as "최고월급"
from jobs
where max_salary >= 10000
order by max_salary desc;

-- 문제 5. 정렬: 월급의 내림차순
-- 월급이 14000 미만 10000 이상인 직원의 이름, 월급, 커미션비율 출력
-- 커미션비율이 null이면 0으로 나타냄
select  first_name || ' ' || last_name as "이름",
        salary as "월급",
        nvl(commission_pct,0) as "커미션비율"
from employees
where salary < 14000
and salary >=10000
order by salary desc;

-- 문제 6. 부서번호가 10, 90, 100 인 직원의 이름, 입사일, 부서번호 출력
-- 입사일은 1977-12 와 같이 표시
select  first_name || ' ' || last_name as "이름",
        lpad(to_char(hire_date, 'YY-MM'),7,'20') as "입사일",
        department_id as "부서아이디"
from employees
where department_id in (10, 90, 100);

-- 문제 7. 이름(first)에 S 또는 s 가 들어가는 직원의 이릅, 월급 출력
select  first_name "이름",
        salary "월급"
from employees
where first_name like '%s%'
or first_name like 'S%';

-- 문제 8. 부서이름이 긴 순서대로 전체부서 출력
select  department_name "부서이름"
from departments
order by length(department_name) desc;

-- 문제 9. 정렬: 나라이름 오름차순
-- 지사가 있을 것으로 예상되는 나라들의 나라이름을 대문자로 출력
select  upper(country_name) "나라이름"
from countries
where country_id is not null
order by country_name asc;

-- 문제 10. 입사일이 03/12/31 이전인 직원의 이름, 월급, 전화번호, 입사일 출력
-- 전화번호는 543-543-3433과 같은 형태로
select  first_name || ' ' || last_name "이름",
        salary "월급",
        replace(phone_number,'.','-') "전화번호",
        hire_date "입사일"
from employees
where hire_date < '03/12/31';