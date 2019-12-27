[6] 각 이름이 ‘s’로 끝나는 사원들의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자(UPPER함수 사용)로 출력하고 머리글은 Employee JOBs로 표시하시오.
	□예 Sigal Tobias is a PU_CLERK
select concat(first_name, ' ', last_name, ' is a ', upper(job_id)) as "Employee JOBs"
from employees
-- where last_name like '%s';
where substr(last_name, -1, 1) = 's';

[7] 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 수당여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 또한 출력 시 연봉이 높은 순으로 정렬한다. 
	- IF, IFNULL
select concat(first_name, ' ' , last_name) as 'Name'
, salary
, ((salary * 12) + (salary * 12 * ifnull(commission_pct,0))) as 'annual salary'
, if(commission_pct is not null, "Salary + Commission", "Salary only") as "수당여부"
from employees
order by ((salary * 12) + (salary * 12 * commission_pct))  desc;


[8] 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오. 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오.
	- DATE_FORMAT()
select concat(first_name, ' ' , last_name) as 'Name'
, hire_date
, date_format(hire_date, '%W') as 'day'
from employees
order by date_format(hire_date, '%w') asc;
	
[9] 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속상사 및 직원이 없다. 소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오.
select count(distinct manager_id) as 'Count M'
from employees;
(추가문제)사원들 중에 부하 직원을 가지고 있지 않은 직원의 수?


[10] 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다. 계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오. 단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 별칭(alias) 처리하시오.
	- GROUP BY, SUM(), AVG(), MAX(), MIN()
	- FORMAT(값, 소수점 표현자리수)
select department_id
, concat('$', format(sum(salary),0)) as 'Sum'
, concat('$', format(avg(salary),1)) as 'Average'
, concat('$', format(max(salary),0)) as 'Maximum'
, concat('$', format(min(salary),0)) as 'Minimum'
from employees
where department_id is not null
group by department_id
order by department_id ;













