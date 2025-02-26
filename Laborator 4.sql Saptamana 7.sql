-- LABORATOR 4 - SAPTAMANA 7

--Daca nu ati fost prezenti in laboratorul anterior se ruleaza urmatoarele tranzactii

-- ATENTIE LA DENUMIREA FOLOSITA PENTRU CELE DOUA TABELE EMP SI DEPT

-- trebuie sa utilizati sirul (EMP_PNU/DEPT_PNU), unde pnu inseamna:
-- p - prima litera din prenume, iar nu - primele doua litere din nume

-- apoi se ruleaza cele doua comenzi

CREATE TABLE EMP_mcu AS SELECT * FROM employees;
CREATE TABLE DEPT_mcu AS SELECT * FROM departments;

desc emp_mcu;
select * from emp_mcu;

LDD - CREATE, ALTER, DROP, RENAME, TRUNCATE
    - aceste comenzi executa COMMIT implicit
    
LMD - SELECT, INSERT, UPDATE, DELETE
    - aceste comenzi NU executa COMMIT implicit

 
-- IN CONTINUARE SE ADAUGA CONSTRANGERILE DE INTEGRITATE

ALTER TABLE emp_mcu
ADD CONSTRAINT pk_emp_mcu PRIMARY KEY(employee_id);

ALTER TABLE dept_mcu
ADD CONSTRAINT pk_dept_mcu PRIMARY KEY(department_id);

ALTER TABLE emp_mcu
ADD CONSTRAINT fk_emp_dept_mcu FOREIGN KEY(department_id) 
REFERENCES dept_mcu(department_id);


ALTER TABLE emp_mcu
ADD CONSTRAINT fk_emp_emp_mcu FOREIGN KEY(manager_id) 
REFERENCES emp_mcu(employee_id); -- managerul unui angajat

ALTER TABLE dept_mcu
ADD CONSTRAINT fk_dept_emp_mcu FOREIGN KEY(manager_id) 
REFERENCES emp_mcu(employee_id); -- managerul de departament


-- APOI SE REZOLVA, IN CADRUL LABORATORULUI CURENT, URMATOARELE EXERCITII


5.	Să se insereze departamentul 300, cu numele Programare în DEPT_pnu.
Analizaţi cazurile, precizând care este soluţia corectă şi explicând erorile 
celorlalte variante. 
Pentru a anula efectul instrucţiunii(ilor) corecte, utilizaţi comanda ROLLBACK.
       
       
DESC DEPT_PNU;

SELECT * FROM dept_pnu;

--discutie tipuri de INSERT si erori posibile
--vezi laborator
                                                      
--a) INSERT IMPLICIT 	
-- trebuie specificate coloanele
INSERT INTO DEPT_mcu
VALUES (300, 'Programare'); -- not enough values



--b) INSERT EXPLICIT
-- obligatoriu trebuie precizate coloanele NOT NULL
-- coloanele care nu sunt speicificate o sa fie completate automat cu NULL
INSERT INTO DEPT_mcu (department_id, department_name)
VALUES (300, 'Programare');

SELECT * FROM dept_mcu;



--c)	
INSERT INTO DEPT_mcu (department_name, department_id)
VALUES (300, 'Programare'); --invalid number
-- ordinea coloanelor din insert into sa corespunda celor din values!

--d)	
INSERT INTO DEPT_mcu (department_id, department_name, location_id)
VALUES (301, 'Programare', null);	
-- unique constraint (USER.PK_DEPT_MCU) violated
-- se incalca constr de unicitate a cheii primare
-- exista deja separt cu id-ul 300
-- varianta corecta
	
_____	


SELECT * FROM dept_mcu;


--e)	
INSERT INTO DEPT_mcu (department_name, location_id)
VALUES ('Programare', null);
-- cannot insert NULL into (USER."DEPT_MCU"."DEPARTMENT_ID")

-- Ce se intampla daca executam rollback?

ROLLBACK;

-- Executati varianta corecta si permanentizati modificarile.

INSERT INTO DEPT_mcu (department_id, department_name)
VALUES (300, 'Programare');

COMMIT;
_____


6.	Să se insereze un angajat corespunzător departamentului introdus anterior 
în tabelul EMP_pnu, precizând valoarea NULL pentru coloanele a căror valoare 
nu este cunoscută la inserare (metoda implicită de inserare). 
Determinaţi ca efectele instrucţiunii să devină permanente.
Atenţie la constrângerile NOT NULL asupra coloanelor tabelului!


-- inserare prin metoda IMPLICITA de inserare
-- dorim sa inseram un angajat in depart 300

DESC emp_mcu;
SELECT * FROM emp_mcu;


INSERT INTO emp_mcu
VALUES (250, NULL, 'nume250', 'email250', NULL, SYSDATE, 'IT_PROG', NULL, NULL, NULL, 300);

-- Cum permanentizam efectul actiunii anterioare?

_____;

SELECT * FROM emp_mcu;


-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_mcu
VALUES (250, NULL, 'nume251', 'email251', NULL, SYSDATE, 'IT_PROG', NULL, NULL, NULL, 300);

-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_mcu
VALUES (251, NULL, 'nume251', 'email251', NULL, '03-10-2023', 'IT_PROG', NULL, NULL, NULL, 300);

-- not a valid month

-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_mcu
VALUES (251, NULL, 'nume251', 'email251', NULL, to_date('03-10-2023', 'DD-MM-YYYY'), 'IT_PROG', NULL, NULL, NULL, 300);

SELECT * FROM emp_mcu;

-- Anulati inserarea anterioara

_____

SELECT * FROM emp_mcu;


-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_mcu
VALUES (251, NULL, 'nume251', 'email251', NULL, '03-10-2023', 
       'IT_PROG', NULL, NULL, NULL, 300);
       
SELECT * FROM emp_mcu;

ROLLBACK;

-- De ce varianta urmatoare nu functioneaza?

INSERT INTO emp_mcu
VALUES (252, NULL, 'nume252', 'email252', NULL, SYSDATE, 
       'IT_PROG', NULL, NULL, NULL, 310);
-- unique constraint (USER.PK_EMP_PNU) violated;

-- IN CELE DIN URMA PASTRAM IN BAZA DE DATE ANGAJATUL CU ID-UL 250 IN DEPART. 300
ROLLBACK;
SELECT * FROM emp_mcu;
SELECT * FROM dept_mcu;

7.	Să se mai introducă un angajat corespunzător departamentului 300, 
precizând după numele tabelului lista coloanelor în care se introduc valori 
(metoda explicita de inserare). 
Se presupune că data angajării acestuia este cea curentă (SYSDATE). 
Salvaţi înregistrarea.
  
desc emp_mcu;

--inserare prin metoda EXPLICITA de inserare
INSERT INTO emp_mcu (hire_date, job_id, employee_id, last_name, email, department_id)
VALUES (sysdate, 'sa_man', 278, 'nume_278', 'email_278', 300);

COMMIT;

SELECT * FROM emp_mcu;


8.	Creaţi un nou tabel, numit EMP1_PNU, care va avea aceeaşi structură ca şi EMPLOYEES, 
dar fara inregistrari. Copiaţi în tabelul EMP1_PNU salariaţii (din tabelul EMPLOYEES) 
al căror comision depăşeşte 25% din salariu (se accepta omiterea constrangerilor).


-- crearea tabelului
CREATE TABLE emp1_mcu AS SELECT * FROM employees;

-- eliminarea inregistrarilor
DELETE FROM emp1_mcu;

-- adaugarea noilor valori (inserarea randurilor)
INSERT INTO emp1_mcu
    SELECT *
    FROM employees
    WHERE commission_pct > 0.25;

SELECT * FROM emp1_mcu;


-- Ce se intampla daca executam un rollback? 

ROLLBACK;




-- SA SE ANALIZEZE EXERCITIILE 9, 10 SI 11 

9.	Să se creeze un fişier (script file) care să permită introducerea de înregistrări 
în tabelul EMP_PNU în mod interactiv. 
Se vor cere utilizatorului: codul, numele, prenumele si salariul angajatului. 
Câmpul email se va completa automat prin concatenarea primei litere din prenume 
şi a primelor 7 litere din nume.    
Executati script-ul pentru a introduce 2 inregistrari in tabel.


INSERT INTO emp_mcu (employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES(&cod, '&&prenume', '&&nume', substr('&prenume',1,1) || substr('&nume',1,7), 
       sysdate, 'it_prog', &sal);
       
UNDEFINE prenume;
UNDEFINE nume;

SELECT * FROM emp_mcu;


10.	Creaţi 2 tabele emp2_pnu şi emp3_pnu cu aceeaşi structură ca tabelul EMPLOYEES, 
dar fără înregistrări (acceptăm omiterea constrângerilor de integritate). 
Prin intermediul unei singure comenzi, copiaţi din tabelul EMPLOYEES:

-  în tabelul EMP1_PNU salariaţii care au salariul mai mic decât 5000;
-  în tabelul EMP2_PNU salariaţii care au salariul cuprins între 5000 şi 10000;
-  în tabelul EMP3_PNU salariaţii care au salariul mai mare decât 10000.

Verificaţi rezultatele, apoi ştergeţi toate înregistrările din aceste tabele.

--VEZI INSERARI MULTI-TABEL IN LABORATORUL 4

CREATE TABLE emp1_mcu AS SELECT * FROM employees;

DELETE FROM emp1_mcu;

SELECT * FROM emp1_mcu; 

CREATE TABLE emp2_mcu AS SELECT * FROM employees;

DELETE FROM emp2_mcu;

CREATE TABLE emp3_mcu AS SELECT * FROM employees;

DELETE FROM emp3_mcu;

INSERT ALL
   WHEN salary < 5000 THEN
      INTO emp1_mcu					
   WHEN salary > = 5000 AND salary <= 10000 THEN
      INTO emp2_mcu
   ELSE 
      INTO emp3_mcu
SELECT * FROM employees;  


SELECT * FROM emp1_mcu;
SELECT * FROM emp2_mcu;
SELECT * FROM emp3_mcu;


11.	Să se creeze tabelul EMP0_PNU cu aceeaşi structură ca tabelul EMPLOYEES 
(fără constrângeri), dar fără inregistrari. 
Copiaţi din tabelul EMPLOYEES:

-  în tabelul EMP0_PNU salariaţii care lucrează în departamentul 80;
-  în tabelul EMP1_PNU salariaţii care au salariul mai mic decât 5000;
-  în tabelul EMP2_PNU salariaţii care au salariul cuprins între 5000 şi 10000;
-  în tabelul EMP3_PNU salariaţii care au salariul mai mare decât 10000.

Dacă un salariat se încadrează în tabelul emp0_pnu atunci acesta nu va mai fi inserat 
şi în alt tabel (tabelul corespunzător salariului său);

CREATE TABLE emp0_mcu AS SELECT * FROM employees;

DELETE FROM emp0_mcu;


INSERT FIRST
    WHEN department_id = 80 THEN
        INTO emp0_mcu
    WHEN salary < 5000 THEN
        INTO emp1_mcu
    WHEN salary > = 5000 AND salary <= 10000 THEN
        INTO emp2_mcu
    ELSE 
        INTO emp3_mcu
SELECT * FROM employees;

SELECT * FROM emp0_mcu;
SELECT * FROM emp1_mcu;
SELECT * FROM emp2_mcu;
SELECT * FROM emp3_mcu;


-- COMANDA UPDATE - VEZI LABORATOR (pentru notiunile teoretice)

12.	Măriţi salariul tuturor angajaţilor din tabelul EMP_PNU cu 5%. 
Vizualizati, iar apoi anulaţi modificările.

UPDATE emp_mcu
SET salary = salary * 1.05;

SELECT * FROM emp_mcu;

ROLLBACK;



13.	Schimbaţi jobul tuturor salariaţilor din departamentul 80 care au comision, în 'SA_REP'. 
Anulaţi modificările.

UPDATE emp_mcu
SET job_id = 'SA_REP'
WHERE department_id = 80 and commission_pct IS NOT NULL;

SELECT * FROM emp_mcu;

ROLLBACK;


14.	Să se promoveze Douglas Grant la manager în departamentul 20 (tabelul dept_pnu), 
având o creştere de salariu cu 1000$. 


-- verificari

SELECT *
FROM emp_mcu
WHERE lower(last_name||first_name) = 'grantdouglas';

-- id-ul 199
-- salariul 2600

SELECT * FROM dept_mcu
WHERE department_id = 20;

-- managerul 201 in depart 20


-- solutia problemei
 
-- manager
UPDATE dept_mcu
set manager_id = (select employee_id 
                from emp_mcu 
                where lower(last_name||first_name) = 'grantdouglas')
where department_id = 20;

rollback;
-- salariul

update emp_mcu
set salary = salary + 1000
where lower(last_name||first_name) = 'grantdouglas';


update emp_mcu
set department_id = (select department_id
                    from dept_mcu
                    where manager_id = (select employee_id
                                        from emp_mcu
                                        where lower(last_name||first_name) = 'grantdouglas'))
where lower(last_name||first_name) = 'grantdouglas';

select * from dept_mcu;


-- COMANDA DELETE - VEZI LABORATOR (pentru notiunile teoretice)

15.	Ştergeţi toate înregistrările din tabelul DEPT_PNU. 
Ce înregistrări se pot şterge? Anulaţi modificările. 

DELETE FROM dept_mcu; 
-- cheia primara din dept este cheie externa in emp
-- deci nu se pot sterge departmentele in care lucreaza angajati

SELECT * FROM dept_mcu;

SELECT * FROM emp_mcu;





16.	Suprimaţi departamentele care nu au angajati. Anulaţi modificările.

-- prima data afisam departamentele care nu au angajati

delete from dept_mcu
where department_id in (select department_id
                        from dept_mcu
                        minus
                        select department_id
                        from emp_mcu);

rollback;
-- apoi stergem departamentele care nu au angajati



17. Să se mai introducă o linie in tabelul DEPT_PNU.

desc dept_mcu;

INSERT INTO dept_mcu
VALUES(320, 'dept_nou', NULL, NULL);

SELECT * FROM dept_mcu;


18. Să se marcheze un punct intermediar in procesarea tranzacţiei (SAVEPOINT p).

SAVEPOINT p;


19. Să se şteargă din tabelul DEPT_PNU departamentele care au codul de departament 
cuprins intre 160 si 200. Listaţi conţinutul tabelului.

DELETE FROM dept_mcu
WHERE department_id BETWEEN 160 AND 200; 

SELECT * FROM dept_mcu;


20. Să se renunţe la cea mai recentă operaţie de ştergere, fără a renunţa 
la operaţia precedentă de introducere. 
Determinaţi ca modificările să devină permanente;

SELECT * FROM dept_mcu;

ROLLBACK TO p;

COMMIT;
