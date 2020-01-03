[1] HR 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 사원수가 5명 이상인 부서의 부서명과 사원수를 출력하시오. 이때 사원수가 많은 순으로 정렬하시오.
	- employees, departments
select e.department_id, d.department_name as '부서명', count(e.department_id) as '사원수'
from employees as e join departments as d
on e.department_id=d.department_id
group by department_id
having count(e.department_id) >= 5
order by count(e.department_id) desc;

[2] 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 급여 등급은 JOB_GRADES 테이블에 표시된다. 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 입사일, 급여, 급여등급을 출력하시오.
	- employees, departments, job_grades
select concat(first_name, ' ' , last_name) as 'Name'
, e.job_id
, d.department_name
, e.hire_date
, e.salary
, j_g.grade_level
from employees as e, departments as d, job_grades as j_g
-- where e.salary between j_g.lowest_sal and j_g.highest_sal
-- and e.department_id=d.department_id;
where e.department_id=d.department_id
and e.salary >= j_g.lowest_sal and 
e.salary <= j_g.highest_sal;

[3] 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Nam으로 별칭), 업무, 급여, 입사일을 출력하시오.
select concat(first_name, ' ' , last_name) as 'Name'
, job_id
, salary
, hire_date
from employees e1
where salary in ( select min(salary) from employees e2 where e1.job_id=e2.job_id group by job_id);
					
[4] 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오
select concat(first_name, ' ' , last_name) as 'Name'
, salary
, department_id
, job_id
from employees e1
where salary > (select avg(salary) from employees e2 
where e1.department_id=e2.department_id );
					
[5] 사원정보(Employees) 테이블에 JOB_ID는 사원의 현재 업무를 뜻하고, JOB_HISTORY에 JOB_ID는 사원의 이전 업무를 뜻한다. 이 두 테이블을 교차해보면 업무가 변경된 사원의 정보도 볼 수 있지만 이전에 한번 했던 같은 업무를 그대로 하고 있는 사원의 정보도 볼 수 있다. 이전에 한번 했던 같은 업무를 보고 있는 사원의 사번과 업무를 출력하시오.
위 결과를 이용하여 출력된 176번 사원의 업무 이력의 변경 날짜 이력을 조회하시오.
select e.employee_id
, e.job_id
from employees e join job_history j_h
on e.employee_id=j_h.employee_id
where e.job_id=j_h.job_id;ㅋ

select employee_id
,job_id
, null as "Start Date"
, null as "End Date"
from employees
where employee_id=176
union
select employee_id
, job_id
, start_date
, end_date
from job_history
where employee_id=176;