-- LABORATOR 8 - SAPTAMANA 12


-- DISCUTIE EXERCITIUL 8
8. Utilizând clauza WITH, să se scrie o cerere care afişează numele departamentelor şi
valoarea totală a salariilor din cadrul acestora. Se vor considera departamentele a căror valoare
totală a salariilor este mai mare decât media valorilor totale ale salariilor tuturor angajatilor.
WITH val_dep AS (SELECT department_name, SUM(salary) AS total
FROM departments d join employees e ON (d.department_id = e.department_id)
GROUP BY department_name
),
val_medie AS (SELECT SUM(total)/COUNT(*) AS medie
FROM val_dep)
SELECT *
FROM val_dep
WHERE total > (SELECT medie
FROM val_medie)
ORDER BY department_name;

-- EX 9

9. Să se afişeze codul, prenumele, numele şi data angajării, pentru angajatii condusi de Steven King 
care au cea mai mare vechime dintre subordonatii lui Steven King. 
Rezultatul nu va conţine angajaţii din anul 1970. 

select * from employees;

-- il selectam pe KING
select employee_id
from employees
where lower(first_name || last_name ) = 'stevenking';

-- preluam subordonatii lui king
with subord as (select employee_id, hire_date
                from employees
                where manager_id = (select employee_id
                                    from employees
                                    where lower(first_name || last_name ) = 'stevenking'
                                    )
                ),
-- preluam subordonatii cu cea mai mare vechime
-- dintre cei de sus
vechime as (select employee_id
            from subord
            where hire_date = (select min(hire_date)
                                from subord)
            ) -- 21-sep-89
-- ceferea principala
select employee_id, first_name, last_name, hire_date
from employees
where employee_id = (select employee_id
                    from vechime
                    );

10. Sa se obtina numele primilor 10 angajati avand salariul maxim. 
Rezultatul se va afişa în ordine crescătoare a salariilor. 

-- Solutia 1: subcerere sincronizată

-- numaram cate salarii sunt mai mari decat linia la care a ajuns

select last_name, salary
from employees e
where 10 >
     (select count(salary) 
      from employees
      where e.salary < salary
     );




-- Solutia 2: analiza top-n 
-- ESTE CORECTA VARIANTA URMATOARE?

select employee_id, last_name, salary, rownum
from (select employee_id, salary, last_name
    from employees
    order by salary desc
    )
where rownum <= 10;



12.	Să se afişeze informaţii despre departamente, în formatul următor: 
"Departamentul <department_name> este condus de {<manager_id> | nimeni} 
şi {are numărul de salariaţi  <n> | nu are salariati}".

SELECT 'Departamentul ' || department_name || ' este condus de ' ||
        NVL(to_char(manager_id), 'nimeni') || ' si ' ||
CASE
WHEN (select count(employee_id)
    from employees
    where d.department_id = department_id
    ) = 0
THEN 'nu are salariati'
ELSE 'are numarul de salariati ' || (select count(employee_id)
                                    from employees
                                    where d.department_id = department_id
                                    )
END "Detalii departament"

FROM departments d;
        


17. Sa se afiseze salariatii care au fost angajati în aceeaşi zi a lunii 
în care cei mai multi dintre salariati au fost angajati 
(ziua lunii insemnand numarul zilei, indiferent de luna si an).

ziua 1 - x ang
ziua 2 - y ang

...
ziua 31 - z ang;

-- AFISAM NUMARUL DE ANGAJATI PENTRU FIECARE ZI
-- indiferent de luna si an

select count(employee_id)
from employees
group by to_char(hire_date, 'dd');

--AFISAM NUMARUL MAXIM DE ANGAJATI
select MAX(count(employee_id))
from employees
group by to_char(hire_date, 'dd'); -- 12 angajati

--afisam ziua in care au fost angajate cele mai multe persoane
select to_char(hire_date, 'dd')
from employees
group by to_char(hire_date, 'dd')
having count(employee_id) = (select MAX(count(employee_id))
                            from employees
                            group by to_char(hire_date, 'dd')
                            ); -- ziua de 24

--cererea principala

select *
from employees
where to_char(hire_date, 'dd') = (select to_char(hire_date, 'dd')
                                from employees
                                group by to_char(hire_date, 'dd')
                                having count(employee_id) = (select MAX(count(employee_id))
                                                            from employees
                                                            group by to_char(hire_date, 'dd')
                                                            ));
                    
            
5.	Să se afişeze codul, numele şi prenumele angajaţilor care au cel puţin doi subalterni. 

a)

select employee_id, last_name, first_name
from employees mgr
where 1 < (select count(employee_id)
           from employees
           where mgr.employee_id = manager_id
          );

--SAU:
select employee_id, last_name, first_name
from employees e join (select manager_id, count(*) 
                       from employees 
                       group by manager_id
                       having count(*) >= 2
                       ) man
on e.employee_id = man.manager_id;


b) Cati subalterni are fiecare angajat? Se vor afisa codul, numele, prenumele si numarul de subalterni.
Daca un angajat nu are subalterni, o sa se afiseze 0 (zero). 


select employee_id, last_name, first_name, (select count()
                                            from
                                            ...) "Nr. subalterni"
___



6.	Să se determine locaţiile în care se află cel puţin un departament.

-- REZOLVATI
-- CEREREA TREBUIE SA AFISEZE 7 LOCATII 
-- VEZI IMAGINEAZA ATASATA IN LABORATOR

-- METODA 1 - IN (care este echivalent cu  = ANY )         


-- METODA 2 - EXISTS



7.	Să se determine departamentele în care nu există niciun angajat.

-- REZOLVATI
-- CEREREA TREBUIE SA RETURNEZE 16 DEPARTAMENTE
-- VEZI IMAGINEAZA ATASATA IN LABORATOR

-- METODA 1 - UTILIZAND NOT IN 

SELECT department_id, department_name
FROM departments d
WHERE ___ NOT IN (SELECT ____
                  FROM ____
                  );


-- METODA 2 - UTILIZAND NOT EXISTS

SELECT department_id, department_name
FROM departments d
WHERE ___ (SELECT 
           FROM 
          );


