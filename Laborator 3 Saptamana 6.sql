--5. Cum se poate implementa full outer join?

-- AFISAM ANGAJATII CARE LUCREAZA IN DEPARTAMENTE (INTERSECTIA) -> 105 ANG
-- PLUS ANGAJATII CARE NU AU DEPARTAMENT -> 1 ANG
-- PLUS DEPARTAMENTELE CARE NU AU ANGAJATOI -> 16 DEPART
-- TOTAL: 123 REZULTATE

select employee_id, last_name, d.department_id, department_name
from employees e full join departments d on (e.department_id = d.department_id);

-- VARIANTA 2
-- OPERATORI PE MULTIMI
-- AFISAM ANGAJATII CARE LUCREAZA IN DEPARTAMENTE (INTERSECTIA) -> 105 ANG
-- PLUS ANGAJATII CARE NU AU DEPARTAMENT -> 1 ANG

select employee_id, last_name, d.department_id, department_name
from employees e left  join departments d on (e.department_id = d.department_id)

UNION -- elementele comune si necomune O SINGURA DATA!!!

-- AFISAM ANGAJATII CARE LUCREAZA IN DEPARTAMENTE (INTERSECTIA) -> 105 ANG
-- PLUS DEPARTAMENTELE CARE NU AU ANGAJATOI -> 16 DEPART

select employee_id, last_name, d.department_id, department_name
from employees e right join departments d on (e.department_id = d.department_id);

----------------------

select employee_id, last_name, d.department_id, department_name
from employees e left join departments d on (e.department_id = d.department_id);
-- total: 123 de randuri in output

-- v2

select last_name, d.department_id, department_name
from employees e left join departments d on (e.department_id = d.department_id)

UNION -- elementele comune si necomune O SINGURA DATA!!!

select last_name, d.department_id, department_name
from employees e right join departments d on (e.department_id = d.department_id);

-- total: 121 de randuri in output
-- deoarece sunt mai multi angajati cu acelasi nume, in acelasi departament

select employee_id, last_name, department_id
from employees
where lower(last_name) = 'smith';
----

select last_name, d.department_id, department_name
from employees e left join departments d on (e.department_id = d.department_id)

UNION ALL

select last_name, d.department_id, department_name
from employees e right join departments d on (e.department_id = d.department_id);


--DISCUTIE OPERATORI PE MULTIMI

select last_name
from employees

UNION

select department_name
from departments;

select last_name
from employees

UNION ALL

select department_name
from departments;


-- EROARE

select employee_id,last_name
from employees

UNION

select department_name, department_id
from departments;


select employee_id, last_name
from employees

UNION

select department_id, department_name
from departments;



6. Se cer codurile departamentelor al căror nume conţine şirul “re” sau în care
lucrează angajaţi având codul job-ului “SA_REP”.
Cum este ordonat rezultatul?

--OPERATORI PE MULTIMI
select department_id
from departments
where lower(department_name) like('%re%')
-- 40,70, 120, 140, 150, 250, 260

UNION

select department_id
from employees
where job_id = 'SA_REP';
-- 80, null
-- and department_id is not null;


--JOIN

select distinct d.department_id
from employees e join departments d on (e.department_id = d.department_id)
where lower(department_name) like('%re%') or
    job_id = 'SA_REP';
-- 70, 40, 80
-- DE CE?
-- deoarece exista departmente care au re in nume, dar care nu au angajati

-- varianta corecta
select distinct d.department_id
from employees e full join departments d on (e.department_id = d.department_id)
where lower(department_name) like('%re%') or
    job_id = 'SA_REP';

-- EX 7

select department_id
from departments
where lower(department_name) like('%re%') or
    job_id = 'SA_REP';
    
    
    
8. Să se obțină codurile departamentelor în care nu lucreaza nimeni (nu este introdus
nici un salariat în tabelul employees). Se cer doua solutii.

-- OPERATORI PE MULTIMI

select department_id
from departments
minus
(select department_id
from departments
intersect
select department_id
from employees);

--

select department_id
from departments
minus
select department_id
from employees;

--JOIN

select department_id from departments

minus

select d.department_id from departments d join 
employees e on (d.department_id = e.department_id);

-- sau

select d.department_id, e.department_id, employee_id, last_name
from departments d  left join employees e on e.department_id=d.department_id
where e.employee_id is null;
--where e.department_id is null
--where last_name is null;

