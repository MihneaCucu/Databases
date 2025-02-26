-- LABORATOR 9
-- DIVISION

EX: Să se obţină codurile salariaţilor ataşaţi tuturor proiectelor pentru care s-a alocat un buget egal cu 10000.

SELECT * FROM PROJECT; -- p2 si p3 proiecte cu buget de 10k
SELECT * FROM WORKS_ON; -- 101, 145, 148, 200 -> angajatii care lucreaza la TOATE proiectele cu buget de 10k

!!! Toate proiectele inseamna ca angajatii sa lucreze OBLIGATORIU la TOATE proiectele cu buget de 10k (la toate - p2 si p3), dar la alte proiecte cu un alt buget.

--Metoda 1 (utilizând de 2 ori NOT EXISTS):
SELECT	DISTINCT employee_id
FROM works_on a  -- cerere parinte C1 cu ajutorul careia se parcurg pe rand toti angajatii care lucreaza la proiecte
WHERE NOT EXISTS
         (SELECT 1
          FROM	project p
          WHERE	budget = 10000
          AND NOT EXISTS
                (SELECT	'x'
                 FROM works_on b
                 WHERE p.project_id = b.project_id
                 AND b.employee_id = a.employee_id
                 ) -- subcererea C3
          ); -- subcererea C2
          
-- sincronizarea dintre cererea parinte C1 si cererea interioara C3 si implicit si C2
-- se realizeaza dupa coloana employee_id -> b.employee_id = a.employee_id
-- ceea ce inseamna ca afisam angajatii din C1 care nu se afla in cererea C2
-- astfel in cererea C2 dorim angajatii care lucreaza la proiecte cu buget diferit de 10k sau
-- care lucreaza doar la o parte din proiectele cu buget de 10k

DIVISION - succesiune de 2 operatori not exists => 

=> Impartim in doua relatii:

angajati lucreaza la proiecte
proiectele au buget de 10k

C1 - din toti angajatii 
not exists 
C2 - ii excludem pe cei care lucreaza la proiecte cu buget diferit de 10k sau
     pe cei care lucreaza doar la o parte din proiectele cu buget de 10k 

Pentru ca in final sa obtinem exact angajatii care lucreaza la toate proiectele cu buget de 10k

   
--Metoda 2 (simularea diviziunii cu ajutorul funcţiei COUNT):
SELECT employee_id
FROM works_on
WHERE project_id IN
                (SELECT	project_id
                 FROM  	project
                 WHERE	budget = 10000
                 )
GROUP BY employee_id
HAVING COUNT(project_id)=
                (SELECT COUNT(*)
                 FROM project
                 WHERE budget = 10000
                 );
                 
amg 500 -> p2, p3, p10, p20
ang 600 -> p2, p10
ang 700 -> p3

500 -> p2
500 -> p3
600 -> p3
700 -> p3
                 
                 
9.	Să se afişeze lista angajaţilor care au lucrat numai pe proiecte 
conduse de managerul de proiect având codul 102.

select * from project;  -- managerul 102 conduce doua proiecte => p1 si p3

select * from works_on; -- angajatii care lucreaza NUMAI pe proiecte coduse de 102 => 
                        -- 136, 140, 150, 162, 176
                        

NUMAI PE PROIECTE CONDUSE DE 102 -> angajatii NU POT lucra si la alte proiecte 
    conduse de un alt manager, dar pot lucra la TOATE sau la o parte din proiectele lui 102;
    
ang 500 -> p1, p3, p10, p20
ang 600 -> p1, p10, p20
ang 700 -> p3
ang 800 -> p1, p3;


select *
from employees
where employee_id in (select employee_id
from works_on
where project_id in (select project_id
                    from project
                    where project_manager = 102 -- p1 si p3
                    )
    
-- pana aici obtinem angajatii care lucreaza fie la p1, fie la p3, fie la ambele
-- dar acesti angajati pot lucra si la alte proiecte


MINUS -- eliminam angajatii care lucreaza si la alte proiecte

select employee_id
from works_on
where project_id in (select project_id
                    from project
                    where project_manager != 102 -- p2
                    )
);

--VARIANTA 2

with mgr_102 as (select project_id
                from project
                where project_manager = 102
                )
select distinct employee_id
from works_on w
where not exists (select 1
                from works_on w2
                where w2.employee_id = w.employee_id
                and w2.project_id not in (select project_id
                                            from mgr_102
                                            )
                );

10.	a) Să se obţină numele angajaţilor care au lucrat 
cel puţin pe aceleaşi proiecte ca şi angajatul având codul 200.

select* from works_on; -- ang 200 lucreaza la p2 si p3

101 -> p2, p3
125 -> p1,p2

CEL PUTIN PE ACELEASI CA SI ANG 200 -> angajatii pot lucra si la alte proiecte
dar OBLIGATORIU SA LUCREZE LA TOATE PROIECTELE LUI 200 -> LA TOATE


select employee_id
from works_on
where project_id in (select project_id
                    from works_on
                    where employee_id = 200 -- p2 si p3
                    )              
-- OBTINEM ANGAJATII CARE LUCREAZA ORI LA TOTE PROIECTELE LUI 200
-- ORI DOAR LA O PARTE DIN ELE
-- NOI DORIM CA ANGAJATII SA LUCREZE LA TOATE                 
group by employee_id
having count(project_id) = (select count(project_id)
                            from works_on
                            where employee_id = 200
                            );        
/*
101 - p2
101 - p3
125 - p2
500 - p2
500 - p3
etc
*/

b) Să se obţină numele angajaţilor care au lucrat cel mult pe aceleaşi proiecte ca şi angajatul având codul 200.

select * from works_on; -- ang 200 lucreaza la p2 si p3

=> 101 (la ambele)
   145 (la ambele) 
   148 (la ambele)
   150 (doar p3)
   162 (doar p3)
   176 (doar p3)
   
select *
from employees
where employee_id in

(

(select employee_id
from works_on
where project_id in (select project_id
                    from works_on
                    where employee_id = 200 -- p2 si p3
                    )
group by employee_id
having count(project_id) <= (select count(project_id)
                            from works_on
                            where employee_id = 200
                            )
                            
-- pana aici angajatii pot lucra la toate proiectele lui 200
-- sau la o parte din ele

MINUS -- sa eliminam angajatii care lucreaza si la alte proiecte

select employee_id
from works_on
where project_id not in (select project_id
                        from works_on
                        where employee_id = 200
                        )
                        
)

UNION

(select employee_id
from employees
where employee_id not in (select employee_id
                            from works_on
                            )
)
);


select employee_id, project_id
from employees left join works_on using (employee_id)
where project_id is not null;

11. Să se obţină angajaţii care au lucrat exact pe aceleaşi proiecte ca şi angajatul având codul 200.

select *
from employees
where employee_id in

(

(select employee_id
from works_on
where project_id in (select project_id
                    from works_on
                    where employee_id = 200 -- p2 si p3
                    )
group by employee_id
having count(project_id) <= (select count(project_id)
                            from works_on
                            where employee_id = 200
                            )
                            
-- pana aici angajatii pot lucra la toate proiectele lui 200
-- sau la o parte din ele

MINUS -- sa eliminam angajatii care lucreaza si la alte proiecte

select employee_id
from works_on
where project_id not in (select project_id
                        from works_on
                        where employee_id = 200
                        )
                        
)

UNION

(select employee_id
from employees
where employee_id not in (select employee_id
                            from works_on
                            )
)
);



1. Să se listeze informaţii despre angajaţii care au lucrat în toate proiectele demarate în primele 6 luni ale anului 2006. 





--VARIABILE DE SUBSTITUTIE
--ex:8
select department_id, round(avg(salary))
from employees
group by department_id
having avg(salary) > &p;

select department_id, round(avg(salary))
from employees
group by department_id
having avg(salary) > &&p;


--EXEMPLU 1:
define c = 101;
select project_id
from works_on
where employee_id = &c;

undefine c;
define;

--EXEMPLU 2: 
define x = &&y;
select &&x from dual;
undefine y;
select &&x from dual;
undefine x;
select &&x from dual;
undefine x;
select &x from dual;

