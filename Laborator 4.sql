//13. Să se afişeze numele angajaţilor şi comisionul. Dacă un angajat nu câştigă comision, să
//se scrie “Fara comision”. Etichetaţi coloana “Comision”.

desc employees;
select * from employees;


NVL(expr1, expr2) - daca expr1 este null, atunci returneaza expr2
                  - altfel returneaza expr2;


!!! Tipurile de date ale celor 2 expresii trebuie sa fie compatibile 
sau expr2 sa se converteasca automat la expr1;


--eroare deoarece tipurile de date ale celor 2 expr nu sunt compatibile

select last_name, nvl(commission_pct, 'Fara comision') "COMISION"
from employees;

--solutia: -> facem conversie explcita

select last_name, nvl(to_char(commission_pct), 'Fara comision') "COMISION"
from employees;

select to_char('5.24', '0.99')
from dual;

--CASE
select last_name,
        case when commission_pct is null then 'Fara comision'
                else to_char(commission_pct, '0.99')
        end "comision"
from employees;


--DECODE
select last_name,
    decode(commission_pct, null, 'Fara comision',commission_pct) "COMISION"
from employees;




--Ex 15
-- CASE VARIANTA 2:
SELECT last_name, job_id, salary,
    CASE WHEN job_id = 'IT_PROG' THEN salary * 1.1
        WHEN job_id ='ST_CLERK' THEN salary * 1.15
        WHEN job_id ='SA_REP' THEN salary*1.2
        ELSE salary
    END "Salariu renegociat"
FROM employees;

-- DECODE:
SELECT last_name, job_id, salary,
    DECODE(job_id, 'IT_PROG', salary * 1.1,
        'ST_CLERK', salary * 1.15,
        'SA_REP', salary * 1.2,
        salary ) "Salariu renegociat"
FROM employees;





//14. Să se listeze numele, salariul şi comisionul tuturor angajaţilor al căror venit lunar
//(salariu + valoare comision) depăşeşte 10 000.

salary + salary * commission_pct = venitul lunar;

--NVL
SELECT last_name, salary, commission_pct, 
        salary + salary * nvl(commission_pct, 0) "VENIT LUNAR"
FROM employees
WHERE nvl(commission_pct, 0) * salary + salary > 10000;

select 12000 + 12000 * null
from dual; --orice operatie matematica cu null este null



--SAU

SELECT last_name, salary, commission_pct, 
        nvl(salary + salary * commission_pct, salary) "VENIT LUNAR"
FROM employees
WHERE nvl(commission_pct * salary + salary, salary) > 10000;



--JOIN


select employee_id, department_name
from employees, departments; --Produs cartezian

-- conditia de join scrisa in where

select employee_id, department_name
from employees e, departments d
where e.department_id = d.department_id;

--106 angajati din cei 107 existenti
-- => un angajat nu are departament

select employee_id, department_name, e.department_id
from employees e, departments d
where e.department_id = d.department_id;

-- join scris in from
-- utilizand on
-- varianta din standardul sql
select employee_id, department_name, e.department_id
from employees e join departments d on e.department_id = d.department_id;


-- join scris in from
-- utilizand using
-- varianta din standardul sql
select employee_id, department_name, department_id
from employees join departments using (department_id);


Ce observați având în vedere numărul de rânduri returnate?

sunt returnati 106 angajati din totalul de 107
deci un angajat nu are departament

se foloseste simbolul (+) in partea deficitara de informatie

-- dorim sa afisam angajatii care au departament
-- dar si pe cei care nu au departament


select employee_id, department_name, e.department_id
from employees e, departments d
where e.department_id = d.department_id (+);


-- dorim sa afisam angajatii care au departament
-- dar si departamentele care nu au angajati


select employee_id, department_name, d.department_id, last_name, salary
from employees e, departments d
where e.department_id (+) = d.department_id;

17. Să se listeze codurile și denumirile job-urilor care există în departamentul 30.

select unique j.job_id, j.job_title
from jobs j,  employees e 
where e.department_id  = 30 and j.job_id = e.job_id;


18. Să se afişeze numele angajatului, numele departamentului şi id-ul locației pentru toţi
angajaţii care câştigă comision.

SELECT last_name, department_name, l.location_id
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND
        d.location_id = l.location_id AND commission_pct is not null;



select * from employees;
select * from departments;

19. Să se afişeze numele, titlul job-ului şi denumirea departamentului pentru toţi angajaţii
care lucrează în Oxford (coloana - city).


select last_name, job_title, city
from employees e, jobs j, locations l, departments d
where e.job_id = j.job_id and e.department_id=d.department_id 
        and d.location_id=l.location_id and city='Oxford';



