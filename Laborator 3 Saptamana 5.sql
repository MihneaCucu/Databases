--LABORATOR 3 SAPTAMANA 5

1. Scrieți o cerere pentru a se afisa numele, luna (în litere) 
şi anul angajării pentru toți salariații din acelasi departament cu Gates, 
al căror nume conţine litera “a”. Se va exclude Gates.

select ang.last_name, to_char(ang.hire_date, 'month yyyy')
from employees ang join employees gates on (ang.department_id = gates.department_id)
where lower(gates.last_name)  = 'gates' 
and ang.last_name like '%a%' 
and lower(ang.last_name) != 'gates';


2. Să se afișeze codul şi numele angajaţilor care lucrează 
în același departament cu cel puţin un angajat al cărui nume conţine litera “t”. 
Se vor afişa, de asemenea, codul şi numele departamentului respectiv. 
Rezultatul va fi ordonat alfabetic după nume.



select ang.employee_id, d.department_name, d.department_id, ang.last_name, angt.last_name
from employees ang join employees angt
on (ang.department_id=angt.department_id)
join departments d
on (ang.department_id=d.department_id)
where lower(angt.last_name) like '%t%'
and ang.employee_id != angt.employee_id
ordered by ang.last_name;

----------------------------------------------------------

select last_name, j.job_id, job_title, department_name, salary
from employees e right join departments d on (e.department_id = d.department_id)
                    left join jobs j on (j.job_id = e.job_id);
                    


