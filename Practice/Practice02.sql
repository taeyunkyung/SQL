-- 문제 1. 매니저가 있는 직원의 수
select  count(*) "haveMngCnt"
from employees
where manager_id is not null;

-- 문제 2. 최고임금과 최저임금 출력, 타이틀 "최고임금, 최저임금"
-- 두 임금의 차이 출력, 타이틀 "최고임금-최저임금"
select  max_salary || ', ' || min_salary "최고임금, 최저임금",
        max_salary - min_salary "최고임금-최저임금"
from jobs;

-- 문제 3. 마지막으로 신입사원이 들어온 날짜, 형식: 2014년 07월 10일
select  to_char(max(hire_date), 'YYYY"년 "MM"월 "DD"일"') answer
from employees;

-- 문제 4. 정렬: 부서번호의 내림차순
-- 부서별 평균임금, 최고임금, 최저임금을 부서아이디와 함께 출력
select  department_id "부서아이디",
        avg(salary) "평균임금",
        max(salary) "최고임금",
        min(salary) "최저임금"
from employees
group by department_id
order by department_id desc;

-- 문제 5. 정렬: 최저임금의 내림차순, 평균임금(소수점 반올림)의 오름차순 순
-- 업무별로 평균임금, 최고임금, 최저임금을 업무아이디와 함께 출력
select  job_id "업무아이디",
        round(avg(salary),1) "평균임금",
        max(salary) "최고임금",
        min(salary) "최저임금"
from employees
group by job_id
order by min(salary) desc, round(avg(salary),1) asc;

-- 문제 6. 가장 오래 근속한 직원의 입사일, 형식: 2000-01-13 토요일
select  to_char(start_date, 'YYYY-MM-DD DAY') answer
from job_history
where (end_date - start_date) = 2100;

select  max(end_date - start_date)
from job_history;

-- 문제 7. 정렬: 평균임금-최저임금 의 내림차순
-- 평균임금과 최저임금의 차이가 2000 미만인 부서의 아이디, 평균임금, 최저임금, 평균임금-최저임금 출력
select  department_id "부서아이디",
        avg(salary) "평균임금",
        min(salary) "최저임금",
        avg(salary)-min(salary) "평균임금-최저임금"
from employees
group by department_id
having avg(salary)-min(salary) < 2000;

-- 문제 8. 정렬: 내림차순, 업무별로 최고임금과 최저임금의 차이 출력
select  max(salary)-min(salary) "최고임금-최저임금"
from employees
group by job_id
order by max(salary)-min(salary) desc;

-- 문제 9. 정렬: 평균급여의 내림차순, 평균급여는 소수점 첫째자리에서 반올림
-- 2005년 이후 입사자 중 평균급여가 5000 이상인 직원의 평균급여, 최소급여, 최대급여를 관리자별로 출력
select  round(avg(salary),1) "평균급여",
        min(salary) "최소급여",
        max(salary) "최대급여"
from employees
group by manager_id
having round(avg(salary),1) >= 5000
order by round(avg(salary),1) desc;

-- 문제 10. 입사일이 02/12/31 일 이전이면 창립멤버, 03년은 03년입사, 04년은 04년입사
-- 이후 입사자는 상장이후입사인 optDate 칼럼의 데이터 출력, 정렬: 입사일의 오름차순
select  first_name "이름",
        case    when hire_date < '02/12/31' then '창립멤버'
                when hire_date between '03/01/01' and '03/12/31' then '03년입사'
                when hire_date between '04/01/01' and '04/12/31' then '03년입사'
                else '상장이후입사'
        end "optDate"
from employees
order by hire_date asc;