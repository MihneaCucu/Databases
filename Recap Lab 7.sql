-- LABORATOR 7 

--exemplu grupare

create table grupare (id number(5) primary key,
                      nume varchar2(10) not null,
                      salariu number(10) not null,
                      manager_id number(5) not null
                      );
                      
select * from grupare;

insert into grupare values (1, 'user1', 1000, 1);

insert into grupare values (2, 'user2', 1400, 1);

insert into grupare values (3, 'user3', 700, 2);

insert into grupare values (4, 'user4', 300, 2);

insert into grupare values (5, 'user5', 1600, 2);

insert into grupare values (6, 'user6', 1200, 2);

commit;

--exemplu folosind clauza where
select *
from grupare
where salariu < 1100;

--exemplu folosind where si grupare
select manager_id, salariu
from grupare
where salariu < 1100
group by manager_id, salariu;

--exemplu folosind where, iar gruparea realizata doar dupa coloana manager_id
select manager_id
from grupare
where salariu < 1100
group by manager_id;

--exemplu folosind having
select max(salariu)
from grupare
having max(salariu) < 10000;

--group by si having
select manager_id, min(salariu)
from grupare
group by manager_id
having min(salariu) <= 1000;

------------------------------------------------

1. 
a) Functiile grup includ valorile NULL in calcule?
b) Care este deosebirea dintre clauzele WHERE şi HAVING? 


2.	Să se afişeze cel mai mare salariu, cel mai mic salariu, suma şi media salariilor tuturor angajaţilor. 
Etichetaţi coloanele Maxim, Minim, Suma, respectiv Media. 
Sa se rotunjeasca media salariilor. 

SELECT MAX(salary) "Maxim", min(salary) "Minim", sum(salary) "Suma", round(avg(salary),2) "Media"
FROM employees;


3.	Să se modifice problema 2 pentru a se afişa minimul, maximul, suma şi media salariilor pentru FIECARE job. 

SELECT MAX(salary) "Maxim", min(salary) "Minim", sum(salary) "Suma", round(avg(salary),2) "Media"
FROM employees
group by job_id;



4.	Să se afişeze numărul de angajaţi pentru FIECARE  departament.

SELECT COUNT(employee_id), department_id
FROM  employees
GROUP BY department_id
having department_id is not null;


5.	Să se determine numărul de angajaţi care sunt şefi. 
Etichetati coloana “Nr. manageri”.

select count(distinct manager_id) "Nr manageri"
from employees;


6.	Să se afişeze diferenţa dintre cel mai mare si cel mai mic salariu. 
Etichetati coloana “Diferenta”.

SELECT max(salary)-min(salary) "Diferenta"
FROM employees;


7.	Scrieţi o cerere pentru a se afişa numele departamentului, locaţia, numărul de angajaţi 
şi salariul mediu pentru angajaţii din acel departament. 
Coloanele vor fi etichetate corespunzător.
Se vor afisa si angajatii care nu au departament

!!!Obs: În clauza GROUP BY se trec obligatoriu toate coloanele prezente în clauza SELECT, 
cu exceptia functiilor de agregare

SELECT department_name, location_id, count(employee_id) "Nr angajati", round(avg(salary)) "Sal. mediu"
FROM employees e left join departments d on (e.department_id = d.department_id)
group by department_name, location_id;


8.	Să se afişeze codul şi numele angajaţilor care au salariul mai mare decât salariul mediu din firmă.
Se va sorta rezultatul în ordine descrescătoare a salariilor.

SELECT employee_id, first_name, last_name
FROM employees 
WHERE salary > (SELECT AVG(salary)
                FROM employees
                )
ORDER BY salary DESC;  



9.	Pentru fiecare şef, să se afişeze codul său şi salariul celui mai prost platit subordonat. 
Se vor exclude cei pentru care codul managerului nu este cunoscut. 
De asemenea, se vor exclude grupurile în care salariul minim este mai mic de 1000$. 
Sortaţi rezultatul în ordine descrescătoare a salariilor.


select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 1000
order by 2 desc;




10.	Pentru departamentele in care salariul maxim depăşeşte 3000$, să se obţină codul, 
numele acestor departamente şi salariul maxim pe departament.

SELECT department_id, department_name, MAX(salary)
FROM departments JOIN employees USING(department_id)
GROUP BY department_id,department_name
HAVING MAX(salary) >= 3000;


11.	Care este salariul mediu minim al job-urilor existente? 
Salariul mediu al unui job va fi considerat drept media aritmetică a salariilor celor care îl practică.

SELECT min(round(avg(salary),2))
FROM employees 
group by job_id;



12.	Să se afişeze maximul salariilor medii pe departamente.

SELECT max(round(avg(salary),2))
from employees
group by department_id;



13.	Sa se obtina codul, titlul şi salariul mediu al job-ului pentru care salariul mediu este minim. 

-- Rezolvati

select j.job_id, job_title, avg(salary)
from employees e join jobs j on (e.job_id = j.job_id)
group by j.job_id, job_title
having avg(salary) = (select min(avg(salary))
                    from employees
                    group by job_id
                    );




14.	Să se afişeze salariul mediu din firmă doar dacă acesta este mai mare decât 2500.

SELECT AVG(salary)
FROM employees
having avg(salary) > 2500;


15.	Să se afişeze suma salariilor pe departamente şi, în cadrul acestora, pe job-uri.

SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id; 


16.	Sa se afiseze codul, numele departamentului si numarul de angajati care lucreaza in acel departament pentru:

a)	departamentele in care lucreaza mai putin de 4 angajati;

SELECT e.department_id, d.department_name, COUNT(*)
FROM employees e JOIN departments d ON (d.department_id = e.department_id )
GROUP BY e.department_id, d.department_name
HAVING COUNT(*) < 4; 


b)	departamentul care are numarul maxim de angajati.

--REZOLVATI

select d.department_id, count(employee_id)
from employees e join departments d on (e.department_id = d.department_id)
group by d.department_id;


select max(count(employee_id)) "Numarul maxim de angajati"
from employees e join departments d on (e.department_id = d.department_id)
group by d.department_id;

select d.department_id, count(employee_id)
from employees e join departments d on (e.department_id = d.department_id)
group by d.department_id, d.department_name
having count(employee_id) = (select max(count(employee_id)) "Numarul maxim de angajati"
from employees e join departments d on (e.department_id = d.department_id)
group by d.department_id);


17.	Să se obţină numărul departamentelor care au cel puţin 15 angajaţi.

--REZOLVATI

select count(count(employee_id)) "Nr. departamente"
from employees e join departments d on (e.department_id = d.department_id)
group by d.department_id
having count(employee_id) >= 15;
