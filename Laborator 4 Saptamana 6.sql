-- LABORATOR 4 - SAPTAMANA 6 

 
1.	Să se creeze tabelele EMP_pnu, DEPT_pnu prin copierea structurii şi conţinutului 
tabelelor EMPLOYEES, respectiv DEPARTMENTS. 

-- în care şirul de caractere “pnu” ->
-- p reprezintă prima literă a prenumelui ->
-- iar nu reprezintă primele două litere ale numelui)


CREATE TABLE EMP_mcu AS SELECT * FROM employees;
CREATE TABLE DEPT_mcu AS SELECT * FROM departments;


2.	Listaţi structura tabelelor sursă şi a celor create anterior. Ce se observă?

-- listam structura
desc emp_mcu;
desc dept_mcu;

desc employees;


3.	Listaţi conţinutul tabelelor create anterior.

--listam continutul
select * from emp)mcu;

CONCLUZIE
Se copiaza datele propriu-zise, coloanele, tipurile de date si dimnesiunile
Se copiaza constrangerile de tip not null.

Nu se copiaza CONSTRANGERILE DE INTEGRITATE (CHEI PRIMARE, CHEI EXTERNE)
Nu se copiaza CONSTRANGERILE UNIQUE, CHECK


-- COMENZILE LDD, LMD SI LCD 

LDD (LIMBAJUL DE DEFINIRE A DATELOR)
    - CREATE, ALTER, DROP, TRUNCATE - aceste comenzi executa un COMMIT implicit;

LMD (LIMBAJUL DE MANIPULARE A DATELOR)
    - SELECT, INSERT, UPDATE, DELETE - aceste comenzi NU executa un COMMIT implicit;

LCD (LIMBAJUL DE CONTROL AL DATELOR) 
    - COMMIT; -salvarea tuturor modificarilor din tranzictia curenta
    - ROLLBACK; - anularea tuturor modificarilor din sesiunea curenta, de la 
                - conectarea pe server sau de la ultimul commit - implicit sau explicit
                
                
CREATE TABLE EMP_mcu AS SELECT * FROM employees;

CREATE TABLE DEPT_mcu AS SELECT * FROM departments;  
    
desc emp_mcu;
select * from emp_mcu;

Ce se intampla daca executam in acest punct comanda ROLLBACK?

ROLLBACK; -nu are efect deoarece comanda create a executat commit implicit



Ce se intampla daca executam comanda COMMIT?

COMMIT;


----------------------------------------------------------------------

insert
insert
insert
rollback; - anuleaza cele 3 inserari
UPDATE
delete
commit; - salveaza update-ul si delete-ul
delete
delete
insert
create -commit
rollback

-----------

insert
insert
savepoint p
delete
delete
rollback to p;
commit;















4.	Pentru introducerea constrângerilor de integritate, 
executaţi instrucţiunile LDD indicate în continuare.

ALTER TABLE emp_pnu
ADD CONSTRAINT pk_emp_pnu PRIMARY KEY(employee_id);


ALTER TABLE dept_pnu
ADD CONSTRAINT pk_dept_pnu PRIMARY KEY(department_id);


ALTER TABLE emp_pnu
ADD CONSTRAINT fk_emp_dept_pnu FOREIGN KEY(department_id) REFERENCES dept_pnu(department_id);
   
   
Obs: Ce constrângere nu am implementat?

___



DESC EMP_PNU;
DESC DEPT_PNU;