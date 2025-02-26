-- SAPTAMANA 9 - LABORATOR 6 - Subcereri Necorelate


1.	Folosind subcereri, să se afişeze numele şi data angajării pentru salariaţii 
care au fost angajaţi după Gates.

SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE INITCAP(last_name)= 'Gates'
                   );


2.	Folosind subcereri, scrieţi o cerere pentru a afişa numele şi salariul 
pentru toţi colegii (din acelaşi departament) lui Gates. Se va exclude Gates. 


select last_name, salary
from employees
where department_id = (select department_id
                        from employees
                        where lower(last_name) = 'gates')
and lower(last_name) != 'gates';

3. Folosind subcereri, să se afişeze numele şi salariul angajaţilor conduşi direct de
preşedintele companiei (acesta este considerat angajatul care nu are manager).




--Se va inlocui Gates cu King;

select last_name, salary
from employees
where department_id = (select department_id
                        from employees
                        where lower(last_name) = 'king')
and lower(last_name) != 'king';



3.	Folosind subcereri, să se afişeze numele şi salariul angajaţilor conduşi direct 
de preşedintele companiei (acesta este considerat angajatul care nu are manager).

-- REZOLVATI INDIVIDUAL

-- CEREREA TREBUIE SA RETURNEZE 14 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR


select last_name, salary
from employees
where manager_id = (select employee_id
                    from employees
                    where manager_id is null);




4.	Scrieți o cerere pentru a afişa numele, codul departamentului și salariul angajaților 
al căror cod de departament și salariu coincid cu codul departamentului și salariul 
unui angajat care câștigă comision. 

SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary
                                  FROM employees
                                  WHERE commission_pct is not null
                                  );
           

                                                                       
5.	Să se afișeze codul, numele și salariul tuturor angajaților al căror salariu 
este mai mare decât salariul mediu din companie.

SELECT employee_id, last_name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) 
                FROM employees);




6.	Scrieti o cerere pentru a afișa angajații care câștigă 
(castiga = salariul plus comision din salariu) 
mai mult decât oricare funcționar (job-ul functionarilor  conţine şirul "CLERK"). 
Sortați rezultatele dupa salariu, în ordine descrescătoare;


select employee_id, salary, commission_pct
from employees
where (salary + salary * nvl(commission_pct, 0)) > all(select max(salary + salary * nvl(commission_pct, 0))
                                            from employees
                                            where upper(job_id) like '%CLERK%')
order by salary desc;



7.	Scrieţi o cerere pentru a afişa numele angajatilor, numele departamentului 
şi salariul angajaţilor care câştigă comision, dar al căror şef direct nu câştigă comision.	

-- REZOLVATI IN ECHIPA DE 2 PERSOANE

-- CEREREA TREBUIE SA RETURNEZE 5 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR

select last_name, department_name, salary
from employees e join departments d on (e.department_id = d.department_id)
where e.commission_pct is not NULL and e.manager_id in (select employee_id
                                                        from employees
                                                        where commission_pct is null);


8.	Să se afişeze numele angajaţilor, codul departamentului şi codul job-ului salariaţilor 
al căror departament se află în Toronto. Sa se rezolve atat cu subcerere, cat si fara subcerere.

-- REZOLVATI IN ECHIPA DE 2 PERSOANE

-- CEREREA TREBUIE SA RETURNEZE 2 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR

-- CU SUBCERERE
select last_name, department_id, job_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id in (select location_id 
                                                from locations
                                                where lower(city) = 'toronto'));

-- FARA SUBCERERE

select last_name, e.department_id, job_id
from employees e join departments d on (e.department_id = d.department_id) join locations l 
            on (d.location_id = l.location_id)
where lower(l.city) = 'toronto';

9.	Să se obțină codurile departamentelor în care nu lucreaza nimeni 
(nu este introdus nici un salariat în tabelul employees). Sa se utilizeze subcereri;

select department_id
from departments
where department_id not in (select nvl(department_id,-1)
                            from employees);



10.	Este posibilă introducerea de înregistrări prin intermediul subcererilor (specificate în locul tabelului). 
Ce reprezintă, de fapt, aceste subcereri? Să se analizeze următoarele comenzi INSERT:

INSERT INTO emp (employee_id, last_name, email, hire_date, job_id, salary, commission_pct) 
VALUES (252, 'Nume252', 'nume252@emp.com', SYSDATE, 'SA_REP', 5000, NULL);

SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct 
FROM emp
WHERE employee_id = 252;

ROLLBACK;

INSERT INTO 
   (SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct 
    FROM emp) 
VALUES (252, 'Nume252', 'nume252@emp.com', SYSDATE, 'SA_REP', 5000, NULL);


SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct 
FROM emp
WHERE employee_id = 252;

ROLLBACK;


11. Sa se creeze tabelul SUBALTERNI care sa contina codul, numele si prenumele angajatilor 
care il au manager pe Steven King, alaturi de codul si numele lui King.
Coloanele se vor numi cod, nume, prenume, cod_manager, nume_manager.

DESC employees;

CREATE TABLE SUBALTERNI_mcu
    (
    );
     

INSERT INTO SUBALTERNI_mcu (cod, nume, prenume, cod_manager, nume_manager)
        (SELECT 
        
        );