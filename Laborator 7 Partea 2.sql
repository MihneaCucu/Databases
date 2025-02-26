-- LABORATOR 7 -- continuare SAPTAMANA 11



18.	Să se obţină codul departamentelor şi suma salariilor angajaţilor care lucrează în acestea, în ordine crescătoare. 
Se consideră departamentele care au mai mult de 10 angajaţi şi al căror cod este diferit de 30.

-- Cand utilizand where? Cand se foloseste having?

select * from employees;

select department_id, sum(salary), count(employee_id)
from employees
where department_id is not null
and department_id != 30
group by department_id
having count(employee_id) > 10
order by count(employee_id);


19.	Care sunt angajatii care au mai avut cel putin doua joburi?


select employee_id
from job_history
group by employee_id
having count(job_id)>=2;




20.	Să se calculeze comisionul mediu din firmă, luând în considerare toate 
liniile din tabel.

select commission_pct
from employees;

select round(avg(commission_pct),2)
from employees;
--where commission_pct is not null; -- 0.22

--avg - suma comisioanelor diferite de null / nr comisionaleor diferite de null;

select round(sum(commission_pct) / 107, 2)
from employees;

--count (coloana) - numara valorile diferite de null;
--count (*) -  numara toate valorile - si pe cele null;

select round(sum(commission_pct) / count(*), 2)
from employees;

select round(sum(commission_pct) / count(employee_id), 2)
from employees;

21.	Scrieţi o cerere pentru a afişa job-ul, salariul total pentru job-ul respectiv pe departamente 
si salariul total pentru job-ul respectiv pe departamentele 30, 50, 80. 
Se vor eticheta coloanele corespunzător. Rezultatul va apărea sub forma de mai jos:

Job	   Dep30   Dep50   Dep80	Total
---------------------------------------

--forma generala;
-- DECODE(value, if1, then1, if2, then2, … , ifN, thenN, else);

select job_id, department_id
from employees;

-- METODA 1
SELECT job_id, SUM(DECODE(department_id, 30, salary)) Dep30,
               SUM(DECODE(department_id, 50, salary)) Dep50,
               SUM(DECODE(department_id, 80, salary)) Dep80,
               SUM(salary) Total
FROM employees
GROUP BY job_id;

-- METODA 2: (cu subcereri corelate în clauza SELECT)
SELECT job_id, (SELECT SUM(salary)
                FROM employees
                WHERE department_id = 30
                AND job_id = e.job_id
               ) Dep30,
               
               (SELECT SUM(salary)
                FROM employees
                WHERE department_id = 50
                AND job_id = e.job_id
               ) Dep50,
                
               (SELECT SUM(salary)
                FROM employees
                WHERE department_id = 80
                AND job_id = e.job_id
               ) Dep80,
               
              SUM(salary) Total
              
FROM employees e
GROUP BY job_id;



23.	Să se afişeze codul, numele departamentului şi suma salariilor pe departamente.

-- Varianta fara subcerere
SELECT d.department_id, department_name, sum(salary)
FROM departments d join employees e ON (d.department_id = e.department_id)
GROUP BY d.department_id, department_name
ORDER BY d.department_id;


-- Varianta cu subcerere in from
SELECT d.department_id, department_name, a.suma
FROM departments d JOIN (SELECT department_id ,SUM(salary) suma 
                     FROM employees
                     GROUP BY department_id
                     ) a -- view in-line
ON ( d.department_id = a.department_id ); 
 


24.	Să se afişeze numele, salariul, codul departamentului si salariul mediu din departamentul respectiv.

-- Varianta fara subcerere -> discutati rezultatul
-- GRESIT!
select last_name, salary, department_id, avg(salary)
from employees join departments using(department_id)
group by department_id,salary,last_name;


-- VARIANTA CORECTA
select last_name, salary, e.department_id, b.Sal_Mediu
from employees e join (select department_id, round(avg(salary)) Sal_Mediu
                        from employees
                        group by department_id
                        ) b
on (e.department_id = b.department_id);