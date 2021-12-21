-- 단일행 서브쿼리 (연산자: =, >, >=, <, <=, <>[같지않다])
select  first_name,
        salary
from employees
where salary >= "Den의 급여";

select  salary
from employees
where first_name = 'Den';

-->
select  first_name,
        salary,
        phone_number,
        department_id
from employees
where salary >= (select salary
                 from employees
                 where first_name = 'Den');

-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호 출력                 
select  first_name,
        salary,
        employee_id
from employees
where salary = (select min(salary)
                from employees);
                
-- 평균 급여보다 적게 받는 사람의 이름, 급여 출력
select  first_name,
        salary
from employees
where salary < (select avg(salary)
                from employees);
                
-- 다중행 서브쿼리: 부서번호가 110인 직원의 급여와 급여가 같은 직원 조회
-- 부서번호가 110인 직원 -> Shelley/12008, William/8300               
select  first_name,
        salary
from employees
where department_id = 110;

-- 급여가 12008인 직원
select employee_id,
        first_name,
        salary
from employees
where salary = 12008;

--급여가 8300인 직원
select employee_id,
        first_name,
        salary
from employees
where salary = 8300;

-- 급여가 12008이거나 8300인 직원
select employee_id,
        first_name,
        salary
from employees
where salary = 12008
or salary = 8300;

select employee_id,
        first_name,
        salary
from employees
where salary in (12008, 8300);

-->
select  employee_id,
        first_name,
        salary
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);
                 
-- 각 부서별로 최고급여를 받는 사원 조회
select  department_id,
        max(salary)
from employees
group by department_id;

-->
select  nvl(department_id,0) 부서아이디, 
        employee_id 사원아이디,
        first_name 이름,
        salary 급여
from employees
where (nvl(department_id,0), salary) in (select nvl(department_id,0), 
                                         		max(salary)
                                  		 from employees
                                  		 group by department_id);
                                  		 
-- 연산자 ANY: 부서번호가 110인 직원의 급여보다 급여가 큰 직원 조회
select  first_name,
        salary
from employees
where salary > 12008
or salary > 8300;

-->
select  first_name,
        salary
from employees
where salary > any(select salary
                   from employees
                   where department_id = 110);


-- 연산자 ALL: 부서번호가 110인 직원의 급여보다 급여가 큰 직원 조회
select  first_name,
        salary
from employees
where salary > 12008
and salary > 8300;

-->
select  first_name,
        salary
from employees
where salary > all(select salary
                   from employees
                   where department_id = 110);
                   
-- 조건절에서 비교 vs 테이블에서 조인: 각 부서별로 최고급여를 받는 사원 조회
-- 조건절
select  department_id,
        max(salary)
from employees
group by department_id;

select  first_name,
        salary
from employees
where salary = (select max(salary)
                from employees);

-->
select  department_id,
        employee_id,
        first_name,
        salary
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                  from employees
                                  group by department_id);

-- 테이블 조인
select  department_id,
        max(salary)
from employees
group by department_id;

select  *
from employees em, (select  department_id,
                            max(salary)
                    from employees
                    group by department_id) ms;

-->                                 
select  em.department_id,
        em.employee_id,
        em.first_name,
        ms.department_id,
        ms.salary
from employees em, (select department_id,
                           max(salary) as salary
                    from employees
                    group by department_id) ms
where em.department_id = ms.department_id
and em.salary = ms.salary;