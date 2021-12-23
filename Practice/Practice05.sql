-- 문제 1. 담당매니저가 배정되어있으나 커미션비율이 없고 월급이 3000초과인 직원의
-- 이름, 매니저아이디, 커미션비율, 월급출력
select  first_name,
        manager_id,
        commission_pct,
        salary
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

-- 문제 2. [조건절비교]각 부서별로 최고급여를 받는 사원의
-- 직원번호, 이름, 급여, 입사일, 전화번호, 부서번호 조회(정렬: 급여의 내립차순)
-- 입사일 형식: 2001-01-13 토요일, 전화번호 형식: 515-123-4567
select  employee_id,
        first_name,
        salary,
        to_char(hire_date, 'YYYY-MM-DD DAY'),
        replace(phone_number, '.', '-')
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;

-- 문제 3. 2005년 이후 입사자 중 매니저 별 평균급여가 5000이상인 직원의
-- 매니저아이디, 매니저이름, 매니저별 평균급여, 매니저별 최소급여, 매니저별 최대급여 출력
-- 정렬: 평균급여의 내립차순, 평균급여: 소수점 첫째자리에서 반올림
select  ma.employee_id,
        ma.first_name,
        m_avg,
        m_min,
        m_max
from (select  em.manager_id,
              round(avg(salary),1) m_avg,
              min(salary) m_min,
              max(salary) m_max
      from (select  manager_id,
                    salary  
            from employees
            where hire_date >= '05/01/01') em
      group by em.manager_id
      having avg(salary) >= 5000
      ) emp, employees ma
where emp.manager_id = ma.employee_id
order by m_avg desc;

/***********************************************************/
select  manager_id
from employees
where hire_date >= '05/01/01';

select  em.manager_id,
        round(avg(salary),1),
        min(salary),
        max(salary)
from (select  manager_id,
              salary  
      from employees
      where hire_date >= '05/01/01') em
group by em.manager_id
having avg(salary) >= 5000;

-- 문제 4. 사번, 이름, 부서명, 매니저의 이름 조회, 부서가 없는 직원 포함
select  em.employee_id,
        em.first_name,
        de.department_name,
        ma.first_name
from employees em, departments de, employees ma
where em.department_id = de.department_id(+)
and em.manager_id = ma.employee_id;

-- 문제 5. 2005년 이후 입사한 직원 중 입사일이 11~20번째로 빠른 직원의
-- 사번, 이름, 부서명, 급여, 입사일 출력(정렬: 입사일 빠른순)
select  rno,
        employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from (select  rownum rno,
              employee_id,
              first_name,
              department_name,
              salary,
              hire_date
        from (select  employee_id,
                      first_name,
                      department_name,
                      salary,
                      hire_date
              from employees em, departments de
              where em.department_id = de.department_id
              and hire_date >= '05/01/01'
              order by hire_date asc)
      )
where rno >= 11
and rno <= 20;

/***********************************************************/
select  employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from employees em, departments de
where em.department_id = de.department_id
and hire_date >= '05/01/01'
order by hire_date asc;

select  rownum rno,
        employee_id,
        first_name,
        department_name,
        salary,
        hire_date
from (select  employee_id,
              first_name,
              department_name,
              salary,
              hire_date
      from employees em, departments de
      where em.department_id = de.department_id
      and hire_date >= '05/01/01'
      order by hire_date asc);
      
-- 문제 6. 가장 늦게 입사한 직원의 이름(first, last)과 연봉, 부서이름 조회
select  first_name || ' ' || last_name 이름,
        salary 연봉,
        department_name 부서이름,
        hire_date
from employees em, departments de
where em.department_id = de.department_id
and hire_date in (select max(hire_date)
                  from employees);
                  
-- 문제 7. 평균 연봉이 가장 높은 부서 직원들의 직원번호, 이름 성, 업무, 연봉 조회
select  em.employee_id 사번,
        em.first_name 이름,
        em.last_name 성,
        em.salary 급여,
        avgt.avgs avg_salary,
        jo.job_title
from employees em, (select  rno,
                            avgs,
                            department_id
                    from (select  rownum rno,
                                  avgs,
                                  department_id
                          from (select  avg(salary) avgs,
                                        department_id
                                from employees
                                group by department_id
                                order by avg(salary) desc)
                          )
                    where rno = 1) avgt, jobs jo
where em.department_id = avgt.department_id
and em.job_id = jo.job_id;

/***********************************************************/
select  avg(salary) avgs
from employees
group by department_id
order by avg(salary) desc;

select  rownum rno,
        avgs
from (select  avg(salary) avgs
      from employees
      group by department_id
      order by avg(salary) desc);
      
select  rno,
        avgs,
        department_id
from (select  rownum rno,
              avgs,
              department_id
      from (select  avg(salary) avgs,
                    department_id
            from employees
            group by department_id
            order by avg(salary) desc)
      )
where rno = 1;

-- 문제 8. 평균급여가 가장 높은 부서 조회
select  department_name
from (select  rownum rno,
              avgs,
              department_id
      from (select  avg(salary) avgs,
                    department_id
            from employees
            group by department_id
            order by avgs desc)
      ) avgt, departments de
where avgt.department_id = de.department_id
and rno = 1;

-- 문제 9. 평균급여가 가장 높은 지역 조회
select region_name
from (select  rownum rno,
              avgs,
              r_id
      from (select  avg(salary) avgs,
                    re.region_id r_id
            from employees em, departments de, locations lo, countries co, regions re
            where em.department_id = de.department_id
            and de.location_id = lo.location_id
            and lo.country_id = co.country_id
            and co.region_id = re.region_id
            group by re.region_id
            order by avgs desc)
      ) avgt, regions reg
where avgt.r_id = reg.region_id
and rno = 1;

/***********************************************************/
select  avg(salary) avgs
from employees em, departments de, locations lo, countries co, regions re
where em.department_id = de.department_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
group by re.region_id;

select  rownum rno,
        avgs,
        r_id
from (select  avg(salary) avgs,
              re.region_id r_id
      from employees em, departments de, locations lo, countries co, regions re
      where em.department_id = de.department_id
      and de.location_id = lo.location_id
      and lo.country_id = co.country_id
      and co.region_id = re.region_id
      group by re.region_id);
      
-- 문제 10. 평균 급여가 가장 높은 업무 조회
select job_title
from (select rownum rno,
              avgs,
              j_id
      from (select  avg(salary) avgs,
                    jo.job_id j_id
            from employees em, jobs jo
            where em.job_id = jo.job_id
            group by jo.job_id
            order by avgs desc)
      ) avgt, jobs job
where avgt.j_id = job.job_id
and rno = 1;