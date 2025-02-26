-- SAPTAMANA 9 - LABORATOR 6 - Subcereri Necorelate

SELECT
FROM
WHERE COL1 = (SELECT COL1
            FROM
            WHERE COL2, COL3 = (SELECT COL2, COL3
                                FROM
                                )
            );

10 = (10) TRUE
10 = (11) FALSE

10 IN (10, 11, 12, 13) TRUE
10 NOT IN (10, 11, 12, 13) FALSE

10 > ALL (1, 2, 3) TRUE
10 > ANY (1, 2, 11) TRUE


1.	Folosind subcereri, să se afişeze numele şi data angajării pentru salariaţii 
care au fost angajaţi după Gates.

SELECT last_name, hire_date
FROM employees 
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE INITCAP(last_name) = 'Gates'
                   );
                   

2.	Folosind subcereri, scrieţi o cerere pentru a afişa numele şi salariul 
pentru toţi colegii (din acelaşi departament) lui Gates. Se va exclude Gates. 

select last_name, salary
from employees
where department_id = (select department_id
                        from employees
                        where INITCAP(last_name) = 'Gates'
                        )
AND INITCAP(last_name) != 'Gates';


--Se va inlocui Gates cu King;

select last_name, salary
from employees
where department_id = (select department_id
                        from employees
                        where INITCAP(last_name) = 'King'
                        )
AND INITCAP(last_name) != 'King';

--single-row subquery returns more than one row
-- cererea returneaza mai multe randuri si nu poate fi utilizat un operator single-row (adica egal)

-- SOLUTIA CORECTA

select last_name, salary
from employees
where department_id IN (select department_id
                        from employees
                        where INITCAP(last_name) = 'King'
                        )
AND INITCAP(last_name) != 'King';

3.	Folosind subcereri, să se afişeze numele şi salariul angajaţilor conduşi direct 
de preşedintele companiei (acesta este considerat angajatul care nu are manager).

-- REZOLVATI INDIVIDUAL

-- CEREREA TREBUIE SA RETURNEZE 14 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR

select last_name, salary
from employees
where manager_id = (select employee_id
                    from employees
                    where manager_id is NULL);




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
WHERE salary > (SELECT round(AVG(salary), 2)
                FROM employees
                );




6.	Scrieti o cerere pentru a afișa angajații care câștigă 
(castiga = salariul plus comision din salariu) 
mai mult decât oricare funcționar (job-ul functionarilor  conţine şirul "CLERK"). 
Sortați rezultatele dupa salariu, în ordine descrescătoare;

castiga = salary + salary * commission_pct
job_id = CLERK


select employee_id, last_name, salary, commission_pct
from employees
where salary + salary * commission_pct > ALL
                                        (select salary + salary * NVL(commission_pct, 0)
                                        from employees
                                        where upper(job_id) like '%CLERK%'
                                        )
order by salary desc;                   
                                        
                                        
10 > (1,2,3)
> ALL -> inseamna mai mare decat toate valorile (mai mare decat maximul)
> ANY -> inseamna mai mare decat cel putin o valoare (mai mare decat minimul)

-- VARIANTA 2
-- mai mare decat maximul

select employee_id, last_name, salary, commission_pct
from employees
where salary + salary * commission_pct > 
                                        (select MAX(salary + salary * NVL(commission_pct, 0))
                                        from employees
                                        where upper(job_id) like '%CLERK%'
                                        )
order by salary desc;  





7.	Scrieţi o cerere pentru a afişa numele angajatilor, numele departamentului 
şi salariul angajaţilor care câştigă comision, dar al căror şef direct nu câştigă comision.	

-- REZOLVATI IN ECHIPA DE 2 PERSOANE

-- CEREREA TREBUIE SA RETURNEZE 5 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR

--cerere nesincronizata

/*select last_name, department_id, salary
from employees
where commission_pct is not null and manager_id in (select employee_id
                                                    from employees
                                                    where commission_pct is null);*/
                                                    
select e.last_name, d.department_name, e.salary
from employees e join departments d on (e.department_id = d.department_id)
where commission_pct is not null and  e.manager_id in ((select employee_id
                                                    from employees
                                                    where commission_pct is null
                                                    and e.manager_id = employee_id));                                                    

--cerere sincronizata

select e.last_name, d.department_name, e.salary
from employees e join departments d on (e.department_id = d.department_id)
where e.commission_pct is not null and exists (select employee_id
                                                    from employees
                                                    where commission_pct is null
                                                    and e.manager_id = employee_id);

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
                                            where initcap(city) = 'Toronto'));

-- FARA SUBCERERE

select emp.last_name, emp.department_id, emp.job_id
from employees emp join departments d on (emp.department_id = d.department_id) join locations l on (d.location_id = l.location_id)
where initcap(l.city) = 'Toronto';

9.	Să se obțină codurile departamentelor în care nu lucreaza nimeni 
(nu este introdus nici un salariat în tabelul employees). Sa se utilizeze subcereri;

select department_id
from departments
where department_id not in(select department_id
                            from employees
                            where department_id is not null);
                            
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

CREATE TABLE SUBALTERNI
    (
    );
     

INSERT INTO SUBALTERNI (cod, nume, prenume, cod_manager, nume_manager)
        (SELECT 
        
        );