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

-->
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