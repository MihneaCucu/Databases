SELECT job_id FROM employees;
-- 107 joburi (randuri) returnate = numarul de angajati
--joburile se repeta deoarece este cheie externa

SELECT job_id FROM jobs;
--avem 19 joburi unice deoarece in acest tabel job_id este cheie primara

SELECT DISTINCT job_id FROM employees;
-- 19 joburi unice in employees => in cadrul joburilor lucreaza angajati

SELECT UNIQUE job_id FROM employees;

select department_id from departments;
--27 depart unice (primary key)

select distinct department_id from employees
where department_id is not null;
--11 departamente in employees
--adica 11 depart in care lucreaza angajati

SELECT last_name || ' , ' || first_name "Nume si Prenume"
FROM employees;

Ex 6 Să se afişeze numele concatenat cu prenumele si cu job_id-ul, separate prin virgula și
spatiu. Etichetați coloana “Detalii Angajat”.

select last_name || ' , ' || first_name "NUME SI PRENUME"
from employees;

Ex 9 Să se modifice cererea de la problema 7 pentru a afişa numele şi salariul angajaţilor al
căror salariu nu se află în intervalul [1400, 24000].

--Varianta 1: Operatori matematici <, <=, >, >=
select last_name, salary
from employees
where salary < 3000 or salary > 10000;

--Varaianta 2: between/ not between
select last_name, salary
from employees
where salary not between 3000 and 10000;

not between - nu afiseaza si capetele intervalului
between - afiseaza si capetele intervalului

Ex 10. Să se afişeze numele, job-ul şi data la care au început lucrul salariaţiiangajaţi între 20
Februarie 1987 şi 1 Mai 1989. Rezultatul va fi ordonat crescător după data de început.

select last_name, job_id, hire_date
from employees
where hire_date between '20-feb-87' and '01-may-89'
order by hire_date;

--metode de sortare

-- dupa numele coloanei
select last_name, job_id, hire_date
from employees
where hire_date between '20-feb-87' and '01-may-89'
order by hire_date;

-- dupa numarul coloanei din clauza select
select last_name, job_id, hire_date
from employees
where hire_date between '20-feb-87' and '01-may-89'
order by 3;

-- dupa alias
select last_name, job_id, hire_date "DATA"
from employees
where hire_date between '20-feb-87' and '01-may-89'
order by "DATA";

Ex 11. Să se afişeze numele salariaţilor şi codul departamentelor pentru toti angajaţii din
departamentele 10 şi 30 în ordine alfabetică a numelor.

select last_name, department_id
from employees
where department_id in (10, 30)
order by last_name;

--not in
select last_name, department_id
from employees
where department_id not in (10, 30)
order by last_name;

--sortare dupa 2 coloane
select last_name, first_name, department_id
from employees
where department_id in (10, 30)
order by last_name, first_name;

Ex 12. Să se modifice cererea de la problema 11 pentru a lista numele şi salariile angajatilor care
câştigă mai mult de 1500 şi lucrează în departamentul 10 sau 30. Se vor eticheta coloanele
drept Angajat si Salariu lunar.

select last_name "Angajat", salary "Salariu lunar", salary, department_id
from employees
where department_id in (10, 30)
    and salary > 1500;
    
--SYSDATE

select sysdate, rownum
from employees
where rownum = 1;

select sysdate
from dual;

select to_char(sysdate, 'DD/MM/YYYY HH24 MI SS')
from dual;

Ex 18. Să se listeze numele tuturor angajatilor care au a treia literă din nume ‘A’.

select last_name
from employees
where lower(last_name) like '__a%';

Ex 14.

select hire_date
from employees
where to_char(hire_date, 'YYYY')=2020;

Ex 19. Să se listeze numele tuturor angajatilor care au cel putin 2 litere ‘L’ in nume şi lucrează în
departamentul 30 sau managerul lor este 102.

select last_name,manager_id
from employees
where lower(last_name) like '%l%l%' and department_id = 30 or manager_id = 102;

Ex 20. Să se afiseze numele, job-ul si salariul pentru toti salariatii al caror job conţine şirul
“CLERK” sau “REP” și salariul nu este egal cu 1000, 2000 sau 3000 $. (operatorul NOT
IN).

select last_name, job_id, salary
from employees
where salary not in (1000, 2000, 3000) and 
    (upper(job_id) like ('%CLERK%') or
    upper(job_id) like ('%REP%'));
    
Ex 15. Să se afişeze numele şi job-ul pentru toţi angajaţii care nu au manager.

select last_name, job_id, manager_id
from employees
where manager_id is null;




