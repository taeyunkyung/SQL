-- 문제 1. 평균급여보다 적은 급여를 받는 직원의 수
select  count(*)
from employees
where salary < (select avg(salary)
                from employees);
                   
-- 문제 2. 평균급여 이상, 최대급여 이하의 월급을 받는 사원의
-- 직원번호, 이름, 급여[, 평균급여, 최대급여 - 사원의??] 출력(정렬: 급여의 오름차순)
select  employee_id,
        salary
from employees
where salary >= (select avg(salary)
                 from employees)
and salary <= (select max(salary)
               from employees)
order by salary asc;

/***********************************************************/
select  avg(salary),
        max(salary)
from employees;

-- 문제 3. 직원 중 Steven King이 소속된 부서가 있는 곳의 주소 조회
-- 도시아이디, 거리명, 우편번호, 도시명, 주, 나라아이디 출력
select  location_id,
        street_address,
        postal_code,
        city,
        state_province,
        country_id
from locations
where location_id = (select de.location_id
                     from employees em, departments de
                     where em.department_id = de.department_id
                     and em.first_name = 'Steven'
                     and em.last_name = 'King');

/***********************************************************/                     
select  department_id
from employees
where first_name = 'Steven'
and last_name = 'King';

select  de.department_id,
        de.location_id
from employees em, departments de
where em.department_id = de.department_id
and em.first_name = 'Steven'
and em.last_name = 'King';

-- 문제 4. job_id가 'ST_MAN'인 직원의 급여보다 급여가 작은 직원의
-- 사번, 이릅, 급여 출력(정렬: 급여의 내림차순)
select  employee_id,
        first_name,
        salary
from employees
where salary < any(select em.salary
                   from employees em, jobs jo
                   where em.job_id = jo.job_id
                   and jo.job_id = 'ST_MAN')
order by salary desc;

/***********************************************************/
select  em.first_name,
        em.salary
from employees em, jobs jo
where em.job_id = jo.job_id
and jo.job_id = 'ST_MAN';

-- 문제 5. 각 부서별로 최고급여를 받는 사원의 직원번호, 이름, 급여, 부서번호(정렬: 급여의 내림차순)
-- 조건절비교, 테이블조인 2가지 방법
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;

select  employee_id,
        first_name,
        ms.salary,
        em.department_id
from employees em, (select department_id,
                           max(salary) salary
                    from employees
                    group by department_id) ms
where em.department_id = ms.department_id
and em.salary = ms.salary
order by ms.salary desc;

-- 문제 6. 연봉의 총합이 가장 높은 업무부터(정렬) 업무명과 연봉의 총합 조회
select  jo.job_title,
        ms.salary
from (select  job_id,
              sum(salary) salary
      from employees
      group by job_id) ms, jobs jo
where ms.job_id = jo.job_id
order by ms.salary desc;

-- [조건절?]

/***********************************************************/
select  job_id,
        sum(salary)
from employees
group by job_id
order by sum(salary) desc;

-- 문제 7. 자신의 부서 평균 급여보다 연봉이 많은 직원의 직원번호, 이름, 급여 조회
select  employee_id,
        first_name,
        em.salary
from employees em, (select avg(salary) salary,
                           department_id
                    from employees
                    group by department_id) avgs
where em.department_id = avgs.department_id
and em.salary > avgs.salary;

-- [조건절?]

/***********************************************************/
select avg(salary)
from employees
group by department_id;

-- 문제 8.