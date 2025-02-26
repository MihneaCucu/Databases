-- LABORATOR 9 - SAPTAMANA 12

select * from project;
select * from works_on;

2.	Să se listeze informaţii despre proiectele la care au participat toţi angajaţii 
care au deţinut alte 2 posturi în firmă.

-- SELECTAM ANGAJATII CARE AU DETINUT 2 POS~TURI IN FIRMA (INT TRECUT)
select * 
from job_history
group by employee_id
having count(job_id) = 2;

-- AFISAM PROIECTELE LA CARE AU LUCRAT ANGAJATII
-- CARE AU DETINUT 2 POSTURI IN FIRMA
-- 101 - p2, p3
-- 176 - p3
-- 200 - p2, p3
select project_id, employee_id
from works_on
where employee_id IN (select employee_id
                    from job_history
                    group by employee_id
                    having count(job_id) = 2
                    ); -- 2, 3, 3, 2, 3,

-- AFISAM PROIECTELE LA CARE AU LUCRAT TOTI ANGAJATII

select project_id, employee_id
from works_on
where employee_id IN (select employee_id
                    from job_history
                    group by employee_id
                    having count(job_id) = 2
                    )
group by project_id
having count(employee_id) = (select count(count(employee_id))
                            from job_history
                            group by employee_id
                            having count(job_id) = 2
                            );

--CEREREA PRINCIPALA
select *
from project
where project_id = (select project_id
                    from works_on
                    where employee_id IN (select employee_id
                                        from job_history
                                        group by employee_id
                                        having count(job_id) = 2
                                        )
                    group by project_id
                    having count(employee_id) = (select count(count(employee_id))
                                                from job_history
                                                group by employee_id
                                                having count(job_id) = 2)
                    );

3.	Să se obţină numărul de angajaţi care au avut cel puţin trei job-uri, 
luându-se în considerare şi job-ul curent.

-- cel putin 3 joburi cu jobul curent inseamna ca in job_history sa aiba cel putin doua 
-- acolo este istoricul joburilor trecute

_____

 


4.	Pentru fiecare ţară, să se afişeze numărul de angajaţi din cadrul acesteia.

_____
   


   

5.	Să se listeze codurile angajaţilor şi codurile proiectelor pe care au lucrat. 
Listarea va cuprinde şi angajaţii care nu au lucrat pe niciun proiect.;

select e.employee_id, project_id
from works_on w right join employees e on w.employee_id = e.employee_id;

