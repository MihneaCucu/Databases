1. Scrieți o cerere pentru a se afisa numele, luna (în litere) şi anul angajării pentru toți
salariații din acelasi departament cu Gates, al căror nume conţine litera “a”. Se va
exclude Gates.

select ang.last_name, to_char(ang.hire_date, 'month yyyy')
from employees ang join employees gates on (ang.department_id = gates.department_id)
where lower(gates.last_name) = 'gates' and lower(ang.last_name) != 'gates'and ang.last_name like '%a%';

2. Să se afișeze codul şi numele angajaţilor care lucrează în același departament cu
cel puţin un angajat al cărui nume conţine litera “t”. Se vor afişa, de asemenea, codul şi
numele departamentului respectiv. Rezultatul va fi ordonat alfabetic după nume.

select ang.employee_id, ang.last_name, d.department_id, department_name, angt.last_name
from employees ang join employees angt on (ang.department_id = angt.department_id) 
                    join departments d on (ang.department_id = d.department_id)
where lower(angt.last_name) like '%l%' and ang.employee_id != angt.employee_id
order by ang.last_name;


3. Să se afișeze numele, salariul, titlul job-ului, oraşul şi ţara în care lucrează
angajații conduși direct de King.

select ang.last_name, ang.salary, j.job_title, l.city, l.country_id
from employees ang join employees king on (ang.manager_id = king.employee_id) join jobs j on (ang.job_id = j.job_id)
                    join departments d on (ang.department_id = d.department_id) join locations l on (d.location_id = l.location_id)
where lower(king.last_name) = 'king';


4. Să se afișeze codul departamentului, numele departamentului, numele și job-ul
tuturor angajaților din departamentele al căror nume conţine şirul ‘ti’. De asemenea, se
va lista salariul angajaţilor, în formatul “$99,999.00”. Rezultatul se va ordona alfabetic
după numele departamentului, şi în cadrul acestuia, după numele angajaţilor.
SELECT d.department_id, department_name, job_id, last_name, to_char(salary,'$99,999.00')
FROM employees e JOIN departments d ON (e.department_id = d.department_id)
WHERE lower(department_name) like '%ti%'
ORDER BY department_name, last_name;

5. Full outer join

select employee_id, last_name, d.department_id, department_name
from employees e full join departments d on(e.department_id = d.department_id);


6.

select department_id
from departments
where lower(department_name) like '%re%'

union

select department_id
from employees
where upper(job_id) like '%SA_REP%';


8. Să se obțină codurile departamentelor în care nu lucreaza nimeni (nu este introdus
nici un salariat în tabelul employees). Se cer doua solutii.
Obs: Operatorii pe mulţimi pot fi utilizaţi în subcereri. Coloanele care apar în clauza
WHERE a interogării trebuie să corespundă, ca număr şi tip de date, celor din clauza
SELECT a subcererii.;


select department_id
from departments

minus

select department_id
from employees;


9. Se cer codurile departamentelor al căror nume conţine şirul “re” şi în care lucrează
angajaţi având codul job-ului “HR_REP”.;

SELECT department_id "Cod departament"
FROM employees
WHERE UPPER(job_id)='HR_REP'
INTERSECT
SELECT department_id
FROM departments
WHERE LOWER(department_name) LIKE '%re%';


