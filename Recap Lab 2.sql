1. Scrieţi o cerere care are următorul rezultat pentru fiecare angajat:
<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori
mai mare>. Etichetati coloana “Salariu ideal”. Pentru concatenare, utilizaţi atât funcţia
CONCAT cât şi operatorul “||”.

SELECT CONCAT(CONCAT(first_name, ' '), last_name) || ' castiga ' || salary || ' lunar, dar doreste '
                    ||salary * 3 "Salariu ideal"
FROM employees;

2.Scrieţi o cerere prin care să se afişeze prenumele salariatului cu prima litera majusculă
şi toate celelalte litere minuscule, numele acestuia cu majuscule şi lungimea
numelui, pentru angajaţii al căror nume începe cu J sau M sau care au a treia literă din
nume A. Rezultatul va fi ordonat descrescător după lungimea numelui. Se vor eticheta
coloanele corespunzător. Se cer 2 soluţii (cu operatorul LIKE şi funcţia SUBSTR).


select initcap(first_name) "Prenume", upper(last_name) "Nume",
    length(last_name) "Lungime Nume"
from employees
where upper(last_name) like 'J%' or upper(last_name) like 'M%' or upper(last_name) like '__A%'
order by length(last_name) desc;


select initcap(first_name) "Prenume", upper(last_name) "Nume",
    length(last_name) "Lungime Nume"
from employees
where substr(upper(last_name),1,1) = 'J' or substr(upper(last_name),1,1) = 'M' or substr(upper(last_name),3,1) = 'A'
order by length(last_name) desc;

3.Să se afişeze, pentru angajaţii cu prenumele „Steven”, codul şi numele acestora, precum
şi codul departamentului în care lucrează. Căutarea trebuie să nu fie case-sensitive, iar
eventualele blank-uri care preced sau urmează numelui trebuie ignorate.

select employee_id, last_name, department_id
from employees
where ltrim(rtrim(upper(first_name))) = 'STEVEN';

select employee_id, last_name, department_id
from employees
where  trim(both from upper(first_name)) = 'STEVEN';

4.Să se afişeze pentru toţi angajaţii al căror nume se termină cu litera 'e', codul, numele,
lungimea numelui şi poziţia din nume în care apare prima data litera 'A'. Utilizaţi alias-uri
corespunzătoare pentru coloane.

select employee_id "ID", last_name "Nume", length(last_name) "Lungime Nume", instr(upper(last_name),'A',1,1) "Pozitie"
from employees
where upper(last_name) like '%E';

select employee_id "ID", last_name "Nume", length(last_name) "Lungime Nume", instr(upper(last_name),'A',1,1) "Pozitie"
from employees
where lower(substr(last_name,-1)) = 'e';

5.Să se afişeze detalii despre salariaţii care au lucrat un număr întreg de săptămâni până
la data curentă.
Obs: Soluția necesită rotunjirea diferenței celor două date calendaristice.

select *
from employees
where mod(round((sysdate - hire_date)),7) = 0;


6. Să se afişeze codul salariatului, numele, salariul, salariul mărit cu 15%, exprimat cu
două zecimale şi numărul de sute al salariului nou rotunjit la 2 zecimale. Etichetaţi
ultimele două coloane “Salariu nou”, respectiv “Numar sute”. Se vor lua în considerare
salariaţii al căror salariu nu este divizibil cu 1000.

SELECT employee_id, last_name, salary,
round(salary + 0.15 * salary, 2) "Salariu Nou",
round((salary + 0.15 * salary) / 100, 2) "Numar sute"
FROM employees
WHERE mod(salary, 1000) != 0;

7. Să se listeze numele şi data angajării salariaţilor care câştigă comision. Să se
eticheteze coloanele „Nume angajat”, „Data angajarii”. Utilizaţi funcţia RPAD pentru a
determina ca data angajării să aibă lungimea de 20 de caractere.

SELECT last_name AS "Nume angajat" , RPAD(to_char(hire_date),20,'X') "Data
angajarii"
FROM employees
WHERE commission_pct is not null;


8. Să se afişeze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.
SELECT to_char (sysdate + 30 , 'MONTH DD YYYY HH24:MI:SS') "Data"
FROM DUAL;

9. Să se afişeze numărul de zile rămase până la sfârşitul anului.
SELECT to_date('31-12-2024','dd-mm-yyyy') - sysdate
FROM dual;

10. a) Să se afişeze data de peste 12 ore.
SELECT TO_CHAR(SYSDATE + 12/24, 'DD/MM HH24:MI:SS') "Data"
FROM DUAL;

b) Să se afişeze data de peste 5 minute

select to_char(sysdate  +5/60/24, 'DD/MM HH24:MI:SS') "Data"
from dual;

11. Să se afişeze numele şi prenumele angajatului (într-o singură coloană), data angajării şi
data negocierii salariului, care este prima zi de Luni după 6 luni de serviciu. Etichetaţi
această coloană “Negociere”.

SELECT concat(last_name, first_name), hire_date,
NEXT_DAY(ADD_MONTHS(hire_date, 6), 'monday') "Negociere"
FROM employees;

12. Pentru fiecare angajat să se afişeze numele şi numărul de luni de la data angajării.
Etichetaţi coloana “Luni lucrate”. Să se ordoneze rezultatul după numărul de luni lucrate.
Se va rotunji numărul de luni la cel mai apropiat număr întreg.

-- prima varianta de ordonare
SELECT last_name, round(months_between(sysdate, hire_date)) "Luni lucrate"
FROM employees
ORDER BY MONTHS_BETWEEN(SYSDATE, hire_date);

-- a doua varianta de ordonare
SELECT last_name, round(months_between(sysdate, hire_date)) "Luni lucrate"
FROM employees
ORDER BY 2;

-- a treia varianta de ordonare
SELECT last_name, round(months_between(sysdate, hire_date)) "Luni lucrate"
FROM employees
ORDER BY "Luni lucrate";
Obs: În clauza ORDER BY, precizarea criteriului de ordonare se poate realiza şi prin
indicarea alias-urilor coloanelor sau a poziţiilor acestora în clauza SELECT.

13. Să se afişeze numele angajaţilor şi comisionul. Dacă un angajat nu câştigă comision, să
se scrie “Fara comision”. Etichetaţi coloana “Comision”.


select last_name, nvl(to_char(commission_pct, '0.99'), 'Fara comision') "Comision"
from employees;

14. Să se listeze numele, salariul şi comisionul tuturor angajaţilor al căror venit lunar
(salariu + valoare comision) depăşeşte 10 000.;

SELECT last_name, salary, commission_pct
FROM employees
WHERE (salary + commission_pct * salary) > 10000;

15. Să se afişeze numele, codul functiei, salariul şi o coloana care să arate salariul după
mărire. Se ştie că pentru IT_PROG are loc o mărire de 10%, pentru ST_CLERK 15%, iar
pentru SA_REP o mărire de 20%. Pentru ceilalti angajati nu se acordă mărire. Să se
denumească coloana "Salariu renegociat".


--CASE VARIANTA 1:
SELECT last_name, job_id, salary,
CASE job_id WHEN 'IT_PROG' THEN salary * 1.1
WHEN 'ST_CLERK' THEN salary * 1.15
WHEN 'SA_REP' THEN salary * 1.2
ELSE salary
END "Salariu renegociat"
FROM employees;

-- CASE VARIANTA 2:
SELECT last_name, job_id, salary,
CASE WHEN job_id = 'IT_PROG' THEN salary * 1.1
WHEN job_id ='ST_CLERK' THEN salary * 1.15
WHEN job_id ='SA_REP' THEN salary*1.2
ELSE salary
END "Salariu renegociat"
FROM employees;

-- DECODE:
SELECT last_name, job_id, salary,
DECODE(job_id, 'IT_PROG', salary * 1.1,
'ST_CLERK', salary * 1.15,
'SA_REP', salary * 1.2,
salary ) "Salariu renegociat"
FROM employees;

16. Să se afişeze codul angajatilor şi numele departamentului pentru toţi angajaţii.

select employee_id, department_name
from employees e, departments d
where e.department_id = d.department_id;

select employee_id, department_name
from employees e join departments d on (e.department_id = d.department_id);

select employee_id,department_name
from employees e join departments d using(department_id);

17. Să se listeze codurile și denumirile job-urilor care există în departamentul 30.

select distinct j.job_id, job_title, department_id
from jobs j, employees e
where j.job_id = e.job_id and department_id = 30;

18. Să se afişeze numele angajatului, numele departamentului şi id-ul locației pentru toţi
angajaţii care câştigă comision.
SELECT last_name, department_name, l.location_id
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND commission_pct is not null;

19. Să se afişeze numele, titlul job-ului şi denumirea departamentului pentru toţi angajaţii
care lucrează în Oxford (coloana - city).

select last_name, job_title, department_name
from employees e, jobs j, departments d, locations l
WHERE e.job_id = j.job_id AND e.department_id = d.department_id AND d.location_id = l.location_id AND lower(l.city) = 'oxford';

20.Să se afişeze codul angajatului şi numele acestuia, împreună cu numele şi codul
şefului său direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.


SELECT ang.employee_id Ang#, ang.last_name Angajat, sef.employee_id Mgr#,
sef.last_name Manager
FROM employees ang, employees sef
WHERE ang.manager_id = sef.employee_id;


21. Să se modifice cererea anterioară pentru a afişa toţi salariaţii, inclusiv cei care nu au şef.

SELECT ang.employee_id Ang#, ang.last_name Angajat, sef.employee_id Mgr#,
sef.last_name Manager
FROM employees ang, employees sef
WHERE ang.manager_id = sef.employee_id(+);

22. Scrieţi o cerere care afişează numele angajatului, codul departamentului în care
acesta lucrează şi numele colegilor săi de departament. Se vor eticheta coloanele
corespunzător.

select ang.last_name "Nume Angajat", ang.department_id, coleg.last_name "Nume Coleg"
from employees ang, employees coleg
where ang.department_id = coleg.department_id and ang.employee_id < coleg.employee_id;

23. Creaţi o cerere prin care să se afişeze numele angajatilor, codul job-ului, titlul job-ului,
numele departamentului şi salariul angajaţilor. Se vor include și angajații al căror
departament nu este cunoscut.

SELECT last_name, j.job_id, job_title, department_name, salary
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id (+)
AND j.job_id = e.job_id;


24. Să se afişeze numele şi data angajării pentru salariaţii care au fost angajaţi după Gates.

SELECT ang.last_name NumeAng, ang.hire_date DataAng,
gates.last_name NumeGates, gates.hire_date DataGates
FROM employees ang, employees gates
WHERE ang.hire_date > gates.hire_date;


25. Să se afişeze numele salariatului şi data angajării împreună cu numele şi data angajării
şefului direct pentru salariaţii care au fost angajaţi înaintea şefilor lor. Se vor eticheta
coloanele Angajat, Data_ang, Manager si Data_mgr.

SELECT ang.last_name Angajat, ang.hire_date Data_Ang, m.last_name Manager,
m.hire_date Data_mgr
FROM employees ang, employees m
WHERE ang.manager_id = m.employee_id AND ang.hire_date < m.hire_date;