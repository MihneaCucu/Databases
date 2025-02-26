2.Să se listeze structura tabelelor din schema HR (EMPLOYEES, DEPARTMENTS, JOBS,
JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS), observând tipurile de date ale
coloanelor.

desc employees;
desc departments;
desc jobs;
desc job_history;
desc locations;
desc countries;
desc regions;



3.Să se listeze conţinutul tabelelor din schema considerată, afişând valorile tuturor
câmpurilor. (SELECT * FROM nume_tabel;)

select * from employees;
select * from departments;
select * from jobs;
select * from job_history;
select * from locations;
select * from countries;
select * from regions;


4.Să se afişeze codul angajatului, numele, codul job-ului, data angajării. Salvati instructiunea
SQL într-un fişier numit Laborator1.sql.

select employee_id, first_name, last_name, hire_date
from employees;

5.Să se listeze, cu şi fără duplicate, codurile job-urilor din tabelul EMPLOYEES.

select job_id from employees;
select distinct job_id from employees;
select unique job_id from employees;


6.Să se afişeze numele concatenat cu prenumele si cu job_id-ul, separate prin virgula și
spatiu. Etichetați coloana “Detalii Angajat”.
Obs: Operatorul de concatenare este “||”. Şirurile de caractere se specifică între apostrofuri
(NU ghilimele, caz în care ar fi interpretate ca alias-uri).;

select last_name || ',' || first_name from employees;

7.Sa se listeze numele si salariul angajaţilor care câştigă mai mult de 2850.

select last_name, first_name, salary 
from employees
where salary > 2850;

8.Să se creeze o cerere pentru a afişa numele angajatului şi numărul departamentului
pentru angajatul având codul 104.


select last_name, first_name, department_id
from employees
where employee_id = 104;

9.Să se modifice cererea de la problema 7 pentru a afişa numele şi salariul angajaţilor al
căror salariu nu se află în intervalul [1400, 24000].

select last_name, first_name, salary 
from employees
where salary not between 1400 and 24000;

9.1. Sa se afiseze numele, prenumele si salariul angajatilor al caror salariu este in intervalul
[3000,7000] => utilizand between


select last_name, first_name, salary 
from employees
where salary between 3000 and 7000;

9.2. Modificarea cererii de la punctual 9.1 fara a utiliza de aceasta data between.

select last_name, first_name, salary 
from employees
where salary >= 3000 and salary <= 7000;

10. Să se afişeze numele, job-ul şi data la care au început lucrul salariaţii angajaţi între 20
Februarie 1987 şi 1 Mai 1989. Rezultatul va fi ordonat crescător după data de început.

select first_name, last_name, job_id, hire_date
from employees
where hire_date between '20-feb-87' and '01-may-89'
order by hire_date;

11.Să se afişeze numele salariaţilor şi codul departamentelor pentru toti angajaţii din
departamentele 10 şi 30 în ordine alfabetică a numelor.

select first_name, last_name, department_id
from employees
where department_id = 10 or department_id = 30
order by last_name;


SAU


select first_name, last_name, department_id
from employees
where department_id in (10,30)
order by last_name;


12. Să se modifice cererea de la problema 11 pentru a lista numele şi salariile angajatilor care
câştigă mai mult de 1500 şi lucrează în departamentul 10 sau 30. Se vor eticheta coloanele
drept Angajat si Salariu lunar.

select last_name "Angajat", department_id, salary "Salariu lunar"
from employees
where department_id in (10,30) and salary > 1500
order by last_name;

13. Care este data curentă? Afişaţi diferite formate ale acesteia.

select sysdate
from dual;

14. Să se afișeze numele şi data angajării pentru fiecare salariat care a fost angajat în 1987.
Se cer 2 soluţii: una în care se lucrează cu formatul implicit al datei şi alta prin care se
formatează data.

select last_name, hire_date
from employees
where hire_date like('%87%');

select last_name, hire_date
from employees
where to_char(hire_date, 'yyyy') = '1987';

15.Să se afişeze numele şi job-ul pentru toţi angajaţii care nu au manager.

select last_name, job_id
from employees
where manager_id is NULL;

16. Să se afișeze numele, salariul și comisionul pentru toti salariații care câștigă comision.
Să se sorteze datele în ordine descrescătoare a salariilor și comisioanelor.

select last_name, salary, commission_pct
from employees
where commission_pct is not NULL
order by salary desc, commission_pct desc;

17. Eliminaţi clauza WHERE din cererea anterioară. Unde sunt plasate valorile NULL în
ordinea descrescătoare?

select last_name, salary, commission_pct
from employees
order by salary desc, commission_pct desc;

18. Să se listeze numele tuturor angajatilor care au a treia literă din nume ‘A’.
Obs: Pentru compararea şirurilor de caractere, împreună cu operatorul LIKE se utilizează
caracterele wildcard:
➢ % - reprezentând orice şir de caractere, inclusiv şirul vid;
➢ _ (underscore) – reprezentând un singur caracter şi numai unul.

select last_name
from employees
where lower(last_name) like '__a%';

19. Să se listeze numele tuturor angajatilor care au cel putin 2 litere ‘L’ in nume şi lucrează în
departamentul 30 sau managerul lor este 102.

select last_name
from employees
where lower(last_name) like '%l%l%l%' and department_id = 30 or manager_id = 102;

20. Să se afiseze numele, job-ul si salariul pentru toti salariatii al caror job conţine şirul
“CLERK” sau “REP” și salariul nu este egal cu 1000, 2000 sau 3000 $. (operatorul NOT
IN).

select last_name, job_id, salary
from employees
where (upper(job_id) like '%CLERK%' or upper(job_id) like '%REP%') and salary not in (1000, 2000, 3000);



