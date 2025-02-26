-- LABORATOR 8 - SAPTAMANA 11

1. 

a) Să se afişeze informaţii (numele, salariul si codul departamentului) 
despre angajaţii al căror salariu depăşeşte valoarea medie a salariilor 
tuturor colegilor din companie.

select last_name, salary, department_id
from employees
where salary >= (select avg(salary) from employees);


b) Să se afişeze informaţii (numele, salariul si codul departamentului) 
despre angajaţii al căror salariu depăşeşte valoarea medie a salariilor 
colegilor săi de departament.

select last_name, salary, department_id
from employees e
where salary >= (select avg(salary) 
                from employees c 
                where e.department_id = c.department_id
                );


c) Analog cu cererea precedentă, afişându-se şi numele departamentului 
şi media salariilor acestuia şi numărul de angajaţi.

-- De ce varianta aceasta este gresita?
-- Argumentati

select last_name, salary, e.department_id, department_name, 
       round(avg(salary)), count(employee_id)
from employees e join departments d on (e.department_id = d.department_id)
group by last_name, salary, e.department_id, department_name;  


-- Discutati variantele incluse in laborator

--Sol 1

SELECT last_name, salary, e.department_id, department_name, sal_med, nr_sal
FROM employees e join departments d on(e.department_id = d.department_id)AVG(salary) sal_med,
COUNT(*) nr_sal
FROM employees
GROUP BY department_id) ac
WHERE e.department_id = d.department_id
AND d.department_id = ac.department_id
AND salary > (SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id);


--Sol 2

SELECT last_name, salary, e. department_id, department_name,
(SELECT round(AVG(salary))
FROM employees
WHERE department_id = e. department_id) “Salariu mediu”,
(SELECT COUNT(*)
FROM employees
WHERE department_id = e. department_id) “Nr angajati”
FROM employees e join departments d on (e.department_id = d.department_id)
WHERE salary > (SELECT AVG(salary)
FROM employees
WHERE department_id = e.department_id);





2.	Să se afişeze numele şi salariul angajaţilor al căror salariu 
este mai mare decât salariile medii din toate departamentele. 
Se cer 2 variante de rezolvare: cu operatorul ALL sau cu funcţia MAX.

-- Varianta cu ALL
SELECT last_name, salary 
FROM employees 
WHERE salary > all (select round(avg(salary))
                    from employees 
                    group by department_id
                    ); -- subcererea calculeaza salariul mediu pentru fiecare departament


-- Varianta cu functia MAX
SELECT last_name, salary 
FROM employees 
WHERE salary > (select ROUND(max(avg(salary)))
                from employees 
                group by department_id
                );



3.	Sa se afiseze numele si salariul celor mai prost platiti angajati 
din fiecare departament.

-- Soluţia 1 (cu sincronizare):
SELECT last_name, salary, department_id
FROM employees e
WHERE salary = (select min(salary)
                from employees
                where e.department_id = department_id
                );


-- Soluţia 2 (fără sincronizare):
SELECT last_name, salary, department_id  
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MIN(salary) 
                                  FROM employees 
                                  GROUP BY department_id
                                  );


-- Soluţia 3: Subcerere în clauza FROM 
               
SELECT last_name, salary, e.department_id, min_sal "SALARIUL MINIM DE DEPARTAMENT"
FROM employees e join (SELECT department_id, MIN(salary) min_sal
                        FROM employees 
                        GROUP BY department_id 
                        ) sal
on (e.department_id = sal.department_id)
where salary = min_sal;




4.	Sa se obtina numele si salariul salariatilor care lucreaza intr-un departament 
in care exista cel putin 1 angajat cu salariul egal cu 
salariul maxim din departamentul 30.

-- METODA 1 - IN

select last_name, salary
from employees
where department_id in

                        (select department_id
                        from employees
                        where salary in         (select max(salary)
                                                from employees
                                                where department_id = 30
                                                )  -- 30, 80, 80
                        );
                        
--80 in (30, 80, 80, 80, 80, etc);
    


-- METODA 2 - EXISTS

select last_name, salary
from employees e
where  exists

                        (select 'x' 
                        from employees
                        where e.department_id = department_id
                        and salary in         (select max(salary)
                                                from employees
                                                where department_id = 30
                                                )  -- 30, 80, 80
                        );
                        

