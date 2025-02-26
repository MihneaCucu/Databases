select to_char(23)
from dual;

char -> 2000 bytes
varchar2 / varchar -> 4000 bytes

SELECT RTRIM('XinfoXxXabc', 'bacX')
FROM DUAL;

SELECT RPAD (lower('InfO'), 7, 'XY')
FROM DUAL;

select translate('$a$aaa', '$a', 'b')
from dual;

select translate('$a$aaa', 'aa', 'bc')
from dual;

(expr_data +/- nr_zile)

select sysdate + 3
from dual;

select to_date('13/03/2024', 'DD/MM/YYYY') + 3
from dual; --16-MAR-24 formatul este cel de pe server
--to_date nu converteste caracter cu caracter


select to_char(to_date('13/03/2024', 'DD/MM/YYYY') + 3, 'dd/mm/yyyy')
from dual; --16/03/2024


select round(sysdate - hire_date)
from employees;


select round(to_date('25/12/2024', 'dd/mm/yyyy') - sysdate)
from dual;


nvl(expr1,expr2) -> dacă expr_1 este NULL, întoarce
expr_2; altfel, întoarce expr_1.


!!! Tipurile celor doua expresii trebuie sa fie comaptibile sau expr_2 sa poata fi converit implicit la expr_1

select nvl(1, 'a')
from dual; -- EROARE deoarece tipurile celor doua expresii nu sunt compatibile si nici expr2 nu se converteste implicit la expr2


-- solutia??
-- sa facem o conversie explicita
select nvl(to_char(1), 'a')
from dual;

select nvl(1, '12')
from dual; -- se face coversie implicita


1. Scrieţi o cerere care are următorul rezultat pentru fiecare angajat:
<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori
mai mare>. Etichetati coloana “Salariu ideal”. Pentru concatenare, utilizaţi atât funcţia
CONCAT cât şi operatorul “||”.

select concat(first_name, ' ' || last_name) || ' castiga '  || salary || ' lunar, dar doreste ' 
    || salary*3 "Salariu ideal"
from employees

2. Scrieţi o cerere prin care să se afişeze prenumele salariatului cu prima litera majusculă
şi toate celelalte litere minuscule, numele acestuia cu majuscule şi lungimea
numelui, pentru angajaţii al căror nume începe cu J sau M sau care au a treia literă din
nume A. Rezultatul va fi ordonat descrescător după lungimea numelui. Se vor eticheta
coloanele corespunzător. 

Se cer 2 soluţii (cu operatorul LIKE şi funcţia SUBSTR);

-- substr 
select initcap(first_name) || ' ' || upper(last_name) || ' ' || length(last_name) 
from employees
where substr(first_name, 1, 1) in ('J', 'M') or upper(substr(last_name, 3, 1)) = 'A';
order by length(first_name) desc;

-- like
select initcap(first_name) || ' ' || UPPER(last_name) || ' ' || length(last_name) 
from employees
where upper(last_name) like 'J%' or upper(last_name) like 'M%' or
upper(last_name) like '__A%'
order by length(first_name) desc;

3. Să se afişeze, pentru angajaţii cu prenumele „Steven”, codul şi numele acestora, precum
şi codul departamentului în care lucrează. Căutarea trebuie să nu fie case-sensitive, iar
eventualele blank-uri care preced sau urmează numelui trebuie ignorate.

-- Varianta 1
SELECT employee_id, last_name, department_id
FROM employees
WHERE LTRIM(RTRIM(UPPER(first_name)))='STEVEN';


-- Varianta 2:
SELECT employee_id, last_name, department_id
FROM employees
WHERE TRIM(BOTH FROM UPPER(first_name))='STEVEN';


4. Să se afişeze pentru toţi angajaţii al căror nume se termină cu litera 'e', codul, numele,
lungimea numelui şi poziţia din nume în care apare prima data litera 'A'. Utilizaţi alias-uri
corespunzătoare pentru coloane.


select employee_id, first_name, last_name, length(last_name),
    instr(upper(last_name), 'A', 1, 1) "Pozitie litera A"
from employees
where last_name like '%e';


select employee_id, first_name, last_name, length(last_name),
    instr(upper(last_name), 'A', 1, 1) "Pozitie litera A"
from employees
where lower(substr(last_name, -1)) = 'e';


--5. Să se afişeze detalii despre salariaţii care au lucrat un număr 
--întreg de săptămâni până la data curentă.

--Obs: Soluția necesită rotunjirea diferenței celor două date calendaristice.


SELECT *
FROM employees
WHERE mod(round(sysdate-hire_date), 7) = 0;


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

SELECT last_name AS "Nume angajat" , RPAD(to_char(hire_date),20,'X') "Data angajarii"
FROM employees
WHERE commission_pct is not null;


8. Să se afişeze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.

SELECT to_char (sysdate + 30, 'MONTH DD YYYY HH24:MI:SS') "Data"
FROM DUAL;


9. Să se afişeze numărul de zile rămase până la sfârşitul anului.

SELECT to_date('31-12-2024','dd-mm-yyyy') - sysdate
FROM dual;




10. a) Să se afişeze data de peste 12 ore.

SELECT TO_CHAR(SYSDATE + 12/24, 'DD/MM HH24:MI:SS') "Data"
FROM DUAL;

b) Să se afişeze data de peste 5 minute
Obs: Cât reprezintă 5 minute dintr-o zi?

select to_char(sysdate  +5/60/24, 'DD/MM HH24:MI:SS') "Data"
from dual;
