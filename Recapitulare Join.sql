-- LABORATOR 3
-- RECAPITULARE JOIN

-- Join-ul este operaţia de regăsire a datelor din două sau mai multe tabele, 
-- pe baza valorilor comune ale unor coloane. De obicei, aceste coloane reprezintă 
-- cheia primară, respectiv cheia externă a tabelelor. 
-- Reamintim că pentru a realiza un join între n tabele
-- o sa fie nevoie de cel puţin n – 1 condiţii de join


--TIPURI DE JOIN:

-- NONEQUIJOIN – condiţia de join conţine alţi operatori decât operatorul de egalitate
--Exemplu Nonequijoin:

SELECT last_name, salary, grade_level, lowest_sal, highest_sal
FROM employees, job_grades
WHERE salary BETWEEN lowest_sal AND highest_sal;

SELECT * FROM job_grades;


-- INNER JOIN (equijoin, join simplu) 
-- corespunde situaţiei în care valorile de pe coloanele ce apar în condiţia 
-- de join trebuie să fie egale

--EXEMPLE (folosind atat join-ul in WHERE cat si cel din standardul SQL3):

-- VARIANTA 1 - Condiția de Join este scrisă în clauza WHERE a instrucțiunii SELECT 
SELECT employee_id, last_name, department_name, d.department_id
FROM employees e, departments d
WHERE e.department_id = d.department_id; 


-- VARIANTA 2 - --JOIN SCRIS IN FROM (standardul SQL3) - folosind ON
SELECT employee_id, last_name, department_name, d.department_id
FROM employees e join departments d ON (e.department_id = d.department_id);
     

-- JOIN SCRIS IN FROM (standardul SQL3) - folosind USING
-- USING SE UTILIZEAZA dacă există coloane având acelasi nume
-- in acest caz coloanele referite nu trebuie sa contina calificatori 
-- adica sa nu fie precedate de nume de tabele sau alias-uri

SELECT employee_id, last_name, department_name, department_id
FROM employees JOIN departments USING(department_id);

-- Cele doua variante (join in where si join in from) sunt echivalente.


-- OUTER JOIN

-- pentru a afisa si angajatii care nu au departament se utilizeaza 
-- simbolul (+) in partea deficitara de informatie

-- deficit de informatie -> angajati FARA departament 
SELECT employee_id, last_name, d.department_id, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id (+);

-- deficit de informatie -> departamente FARA angajati 
SELECT employee_id, last_name, d.department_id, department_name
FROM employees e, departments d
WHERE e.department_id (+) = d.department_id;


-- In cazul standardului SQL3 se utilizeaza LEFT, RIGHT şi FULL OUTER JOIN
-- DISCUTIE!


-- CROSS JOIN - produs cartezian
SELECT employee_id, last_name, e.department_id, department_name
FROM employees e CROSS JOIN departments d;


-- NATURAL JOIN 
SELECT last_name, job_id, job_title                       
FROM employees NATURAL JOIN jobs;   

SELECT last_name, e.job_id, job_title 
FROM employees e, jobs j 
WHERE e.job_id = j.job_id;

--AFISAM DEPARTAMENTELE CARE AU ANGAJATI
--PLUS DEPART CARE NU AU ANGAJATI
-- ADICA AFISAM TOATE DEPART - CHIAR DACA AU SAU NU ANGAJATI
-- LEFT JOIN

SELECT employee_id, last_name, department_name, d.department_id
FROM employees e LEFT OUTER JOIN departments d ON (e.department_id = d.department_id);

--RIGHT JOIN
--AFISAM DEPARTAMENTELE CARE AU ANGAJATI
--PLUS DEPART CARE NU AU ANGAJATI
-- ADICA AFISAM TOATE DEPART - CHIAR DACA AU SAU NU ANGAJATI

SELECT employee_id, last_name, department_name, d.department_id
FROM employees e RIGHT JOIN departments d ON (e.department_id = d.department_id);

--FULL JOIN
--AFISAM DEPARTAMENTELE CARE AU ANGAJATI
--AFISAM DEPARTAMENTELE CARE AU ANGAJATI
--PLUS DEPART CARE NU AU ANGAJATI

SELECT employee_id, last_name, department_name, d.department_id
FROM employees e FULL JOIN departments d ON (e.department_id = d.department_id);

--CROSS JOIN - produs cartezian

SELECT employee_id, last_name, department_name, d.department_id
FROM employees e CROSS JOIN departments d;



-- NATURAL JOIN 
SELECT last_name, job_id, job_title                       
FROM employees NATURAL JOIN jobs;   

SELECT last_name, e.job_id, job_title 
FROM employees e, jobs j 
WHERE e.job_id = j.job_id;








