-- LABORATOR 2 - SAPTAMANA 5

20. Să se afişeze codul angajatului şi numele acestuia, împreună cu numele şi codul
şefului său direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.


SELECT ang.employee_id Ang#, ang.last_name Angajat, 
    sef.employee_id Mgr#,   sef.last_name Manager
FROM employees ang, employees sef
WHERE ang.manager_id = sef.employee_id;

21. Să se modifice cererea anterioară pentru a afişa toţi salariaţii, 
inclusiv cei care nu au şef.

SELECT ang.employee_id Ang#, ang.last_name Angajat, 
    sef.employee_id Mgr#,   sef.last_name Manager
FROM employees ang, employees sef
WHERE ang.manager_id = sef.employee_id (+) ;

22. Scrieţi o cerere care afişează numele angajatului, codul departamentului 
în care acesta lucrează şi numele colegilor săi de departament. 
Se vor eticheta coloanele corespunzător.


select ang.last_name "NUME ANGAJAT", ang.department_id "DEPARTAMENT", 
    coleg.last_name "NUME COLEG"
from employees ang, employees coleg
where ang.department_id = coleg.department_id
and ang.employee_id < coleg.employee_id;

23. Creaţi o cerere prin care să se afişeze numele angajatilor, 
codul job-ului, titlul job-ului, numele departamentului şi salariul angajaţilor.
Se vor include și angajații al căror departament nu este cunoscut.

SELECT last_name, j.job_id, job_title, department_name, salary
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id (+)
    AND j.job_id = e.job_id;
    
24. Să se afişeze numele şi data angajării pentru salariaţii care au fost angajaţi după Gates.

SELECT ang.last_name NumeAng, ang.hire_date DataAng,
    gates.last_name NumeGates, gates.hire_date DataGates
FROM employees ang, employees gates
WHERE ang.hire_date > gates.hire_date
AND lower(gates.last_name) like 'gates'; 

25. Să se afişeze numele salariatului şi data angajării 
împreună cu numele şi data angajării şefului direct pentru salariaţii 
care au fost angajaţi înaintea şefilor lor. Se vor eticheta
coloanele Angajat, Data_ang, Manager si Data_mgr.

SELECT ang.last_name Angajat, ang.hire_date Data_Ang, m.last_name Manager,
m.hire_date Data_mgr
FROM employees ang, employees m
WHERE ang.manager_id = m.employee_id AND ang.hire_date < m.hire_date;



