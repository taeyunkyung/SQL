-- 문제 1. 정렬: 부서이름의 오름차순, 사번의 내림차순
-- 직원들의 사번, 이름, 성과 부서명을 조회하여 출력
select  employee_id,
        first_name,
        last_name,
        department_name
from employees em, departments de
where em.department_id = de.department_id
order by department_name asc, employee_id desc;

-- 문제 2. 정렬: 사번의 오름차순, 부서가 없는 사번 표시 안함
-- 직원들의 사번, 이름, 급여, 부서명, 현재업무, 사번 출력
select  employee_id,
        first_name,
        salary,
        department_name,
        job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id
order by employee_id asc;

-- 문제 2-1. 부서가 없는 Kimberely의 사번까지 표시
select  employee_id,
        first_name,
        salary,
        department_name,
        job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id(+)
and em.job_id = jo.job_id
order by employee_id asc;

-- 문제 3. 정렬: 도시아이디의 오름차순, 부서가 없는 도시 표시 안함
-- 도시아이디, 도시명, 부서명, 부서아이디 출력
select  lo.location_id,
        city,
        department_name,
        department_id
from departments de, locations lo
where de.location_id = lo.location_id
order by lo.location_id asc;

-- 문제 3-1. 부서가 없는 도시도 표시
select  lo.location_id,
        city,
        department_name,
        department_id
from departments de right outer join locations lo
on de.location_id = lo.location_id
order by lo.location_id asc;

-- 문제 4. 정렬: 지역이름의 오름차순, 나라이름의 내림차순
-- 지역에 속한 나라들의 지역이름, 나라이름 출력
select  region_name,
        country_name
from countries co, regions re
where co.region_id = re.region_id
order by region_name asc, country_name desc;

-- 문제 5. 자신의 매니저보다 채용일이 빠른 사원의
-- 사번, 이름, 채용일, 매니저이름, 매니저 입사일 조회
select  em.employee_id,
        em.first_name,
        em.hire_date,
        ma.first_name manager,
        ma.hire_date manager
from employees em, employees ma
where em.manager_id = ma.employee_id
and em.hire_date < ma.hire_date;

-- 문제 6. 정렬: 나라명의 오름차순, 값이 없는 경우 표시 안함
-- 나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디 출력
select  country_name,
        co.country_id,
        city,
        lo.location_id,
        department_name,
        department_id
from departments de, locations lo, countries co
where de.location_id = lo.location_id
and lo.country_id = co.country_id
order by country_name asc;

-- 문제 7. 과거의 업무아이디가 'AC_ACCOUNT'로 근무한 사원의 
-- 사번, 이름(first, last), 업무아이디, 시작일, 종료일 출력
select  em.employee_id,
        first_name || ' ' || last_name,
        jh.job_id,
        start_date,
        end_date
from employees em, job_history jh
where em.employee_id = jh.employee_id
and jh.job_id = 'AC_ACCOUNT';

-- 문제 8. 각 부서의 부서번호, 부서이름, 매니저 이름,
-- 위치한 도시, 나라의 이름, 지역구분의 이름 출력
select  de.department_id,
        department_name,
        ma.first_name manager,
        city,
        country_name,
        region_name
from departments de, employees em, employees ma, locations lo, countries co, regions re
where de.manager_id = em.employee_id
and de.manager_id = ma.employee_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id;

-- 문제 9. 사원의 사번, 이름, 부서명, 매니저의 이름 조회, 부서가 없는 직원도 표시
select  em.employee_id,
        em.first_name,
        department_name,
        ma.first_name manager        
from employees em, departments de, employees ma
where em.department_id = de.department_id(+)
and em.manager_id = ma.employee_id;