-- rownum 이해
select  rownum no,
        first_name,
        salary
from employees;

-- 급여순으로 정렬: rownum 섞이는 문제
select  rownum no,
        first_name,
        salary
from employees
order by salary desc;

-- orderSalary 테이블
select  first_name,
        salary
from employees
order by salary desc;

-- 쓸 것만 추려서 * 바꾸기      
select  rownum,
        first_name,
        salary
from (select  *
      from employees
      order by salary desc);
      
-->
select  rownum,
        first_name,
        salary,
        email
from (select  first_name,
              salary,
              email
      from employees
      order by salary desc);

-- 급여를 가장 많이 받는 직원 5명의 이름 출력(1번부터)
select  rownum,
        first_name,
        salary,
        email
from (select  first_name,
              salary,
              email
      from employees
      order by salary desc) o
where rownum <= 5;

--> (1)정렬하기 (2)rownum 붙이기 (3)where절 사용하기
select  rno,
        first_name,
        salary
from (select  rownum rno,
              first_name,
              salary
      from (select  first_name,
                    salary
            from employees
            order by salary desc)
      )
where rno >= 11
and rno <= 20;

-- 07년에 입사한 직원 중 급여가 많은 순으로 3에서 7등인 직원의 이름, 급여, 입사일 출력
select  rno,
        first_name,
        salary,
        hire_date
from (select  rownum rno,
              first_name,
              hire_date,
              salary
      from (select  first_name,
                    hire_date,
                    salary
            from employees
            where to_char(hire_date, 'YY') = '07'
            order by salary desc)
      )
where rno >= 3
and rno <=7;

/***********************************************************/
select  first_name,
        hire_date,
        salary
from employees
where to_char(hire_date, 'YY') = '07'
order by salary desc;

select  rownum rno,
        first_name,
        hire_date,
        salary
from (select  first_name,
              hire_date,
              salary
      from employees
      where to_char(hire_date, 'YY') = '07'
      order by salary desc);

/***********************************************************/     
select  first_name,
        hire_date,
        salary
from employees
where hire_date >= '07/01/01'
and hire_date < '08/01/01'
and department_id is not null
order by salary desc;

select  rownum rno,
        first_name,
        hire_date,
        salary
from (select  first_name,
              hire_date,
              salary
      from employees
      where hire_date >= '07/01/01'
      and hire_date < '08/01/01'
      and department_id is not null
      order by salary desc);
      
-- 07년에 입사한 직원 중 급여가 많은 순으로 3에서 7등인 직원의 이름, 급여, 입사일, 부서명
select  rno,
        first_name,
        salary,
        hire_date,
        de.department_name
from (select  rownum rno,
              first_name,
              hire_date,
              salary,
              d_id
      from (select  first_name,
                    hire_date,
                    salary,
                    nvl(department_id,0) d_id
            from employees
            where to_char(hire_date, 'YY') = '07'
            order by salary desc) 
      ) r, departments de
where r.d_id = de.department_id(+)
and rno >= 3
and rno <= 7;

/***********************************************************/   
select  rno,
        first_name,
        salary,
        hire_date,
        de.department_id
from (select  rownum rno,
              first_name,
              hire_date,
              salary,
              d_id
      from (select  first_name,
                     hire_date,
                     salary,
                     department_id d_id
            from employees
            where hire_date >= '07/01/01'
            and hire_date < '08/01/01'
            and department_id is not null
            order by salary desc) 
      ) r, departments de
where r.d_id = de.department_id
and rno >= 3
and rno <= 7;

/***********************************************************/   
select  rno,
        first_name,
        salary,
        hire_date,
        dn
from (select  rownum rno,
              first_name,
              hire_date,
              salary,
              eid,
              dn
      from (select  first_name,
                     hire_date,
                     salary,
                     em.department_id eid,
                     de.department_name dn
            from employees em, departments de
            where em.department_id = de.department_id
            and hire_date >= '07/01/01'
            and hire_date < '08/01/01'
            order by salary desc) 
      )
where rno >= 3
and rno <= 7;