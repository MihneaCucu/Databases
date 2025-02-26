-- LABORATOR 5 - SAPTAMANA 8

-- Limbajul de definire a datelor (LDD) 

--COMENZI CARE FAC PARTE DIN LDD:

CREATE, ALTER, DROP, TRUNCATE, RENAME

--Ce comanda LCD se executa dupa instructiunile de tip LDD?

_____

-- Crearea tabelelor (vezi notiunile in laborator 5)


-- EXERCITII 


1. Să se creeze tabelul ANGAJATI_pnu 
(pnu se alcatuieşte din prima literă din prenume şi primele două din numele studentului) 
corespunzător schemei relaţionale:

ANGAJATI_mcu(cod_ang number(4), nume varchar2(20), prenume varchar2(20), email char(15), 
             data_ang date, job varchar2(10), cod_sef number(4), salariu number(8, 2), 
             cod_dep number(2)
            );
  
a) cu precizarea cheilor primare la nivel de coloană 
si a constrangerilor NOT NULL pentru coloanele nume şi salariu;          

CREATE TABLE angajati_mcu
      ( cod_ang number(4) CONSTRAINT PKEY_ANG_MCU PRIMARY KEY,
        nume varchar2(20) NOT NULL,
        prenume varchar2(20),
        email char(15) CONSTRAINT EMAIL_UNIC_MCU UNIQUE,
        data_ang date  DEFAULT SYSDATE,
        job varchar2(10),
        cod_sef number(4),
        salariu number(8,2) CONSTRAINT SAL_NOT_NULL_MCU NOT NULL,
        cod_dep number(2)
       );
 
SELECT * FROM angajati_mcu;
DESC angajati_mcu;
    

b) cu precizarea cheii primare la nivel de tabel 
si a constrângerilor NOT NULL pentru coloanele nume şi salariu.

DROP TABLE angajati_mcu;

CREATE TABLE angajati_mcu
      ( cod_ang number(4),
        nume varchar2(20) constraint nume_not_null_ang not null,
        prenume varchar2(20),
        email char(15) constraint email_unique unique,
        data_ang date default sysdate,
        job varchar2(10),
        cod_sef number(4),
        salariu number(8, 2) constraint salariu_ang not null,
        cod_dep number(2),
        constraint pkey_ang primary key(cod_ang) --constrangere la nivel de tabel
       );
 



-- Rezolvati urmatoarele exercitii:


2. Adăugaţi următoarele înregistrări în tabelul ANGAJATI_pnu:

-- Analizati tabelul din Laborator 5

-- 1
-- metoda explicita (se precizeaza coloanele)
INSERT INTO angajati_mcu(cod_ang, nume, prenume, data_ang, job, salariu, cod_dep)
VALUES(100, 'nume1', 'prenume1', null, 'Director', 20000, 10);

SELECT * FROM angajati_mcu;

DE CE A FOST PRECIZATA COLOANA data_ang si nu a fost precizata coloana cod_sef?
R: a fost precizata col data_ang deaorece dorim sa inseram null si nu valoarea default sysdate
- nu a fost precizata coloana cod_sef deaorece se poate insera null in aceasta coloana

-- 2           
-- metoda implicita de inserare (nu se precizeaza coloanele)

desc angajati_mcu

INSERT INTO angajati_mcu
VALUES(101, 'nume2', 'prenume2', 'nume2', to_date('02-02-2004','dd-mm-yyyy'), 
       'Inginer', 100, 10000, 10);
   
-- 3          
INSERT INTO angajati_mcu
VALUES(102, 'nume3', 'prenume3', 'nume3', to_date('05-06-2000','dd-mm-yyyy'), 
       'Analist', 101, 5000, 20);

-- 4             
INSERT INTO angajati_mcu(cod_ang, nume, prenume, data_ang, job, cod_sef, salariu, cod_dep)
VALUES(103, 'nume4', 'prenume4', null, 'Inginer', 100, 9000, 20);

-- 5       
INSERT INTO angajati_mcu
VALUES(104, 'nume5', 'prenume5', 'nume5', null, 'Analist', 101, 3000, 30);

-- salvam inregistrarile
COMMIT;

SELECT * FROM angajati_mcu;


2. Modificarea (structurii) tabelelor (vezi notiunile din laborator - pagina 3)

-- EXERCITII

3. Introduceti coloana comision in tabelul ANGAJATI. 
Coloana va avea tipul de date NUMBER(4,2).

DESC angajati_mcu;

ALTER TABLE angajati_mcu
ADD comision number(4,2);

SELECT * FROM angajati_mcu;


4. Este posibilă modificarea tipului coloanei salariu în NUMBER(6,2) – 6 cifre si 2 zecimale?

SELECT * FROM angajati_mcu;
DESC angajati_pnu;

ALTER TABLE angajati_mcu
MODIFY (salariu number(6,2));
-- column to be modified must be empty to decrease dimension


5. Setaţi o valoare DEFAULT pentru coloana salariu.

SELECT * FROM angajati_mcu;
DESC angajati_mcu;

ALTER TABLE angajati_mcu
MODIFY (salariu number(8,2) default 100); 
                 -- atentie la tipul de date si dimensiunea coloanei


6. Modificaţi tipul coloanei comision în NUMBER(2, 2) 
şi al coloanei salariu la NUMBER(10,2), în cadrul aceleiaşi instrucţiuni.

DESC angajati_mcu;

SELECT * FROM angajati_mcu;

ALTER TABLE angajati_mcu
MODIFY (comision number(2,2),
        salariu number(10,2)
        );

De ce au fost permise cele doua modificari de mai sus?

R: pentru salariu am crescut dimensiunea
iar pentru comision am scazut dimensiunea, operatia fiind permisa deoarece
comisionul avea valori null



7. Actualizati valoarea coloanei comision, setând-o la valoarea 0.1 
pentru salariaţii al căror job începe cu litera A. (UPDATE)

UPDATE angajati_mcu
SET comision = 0.1
WHERE upper(job) LIKE 'A%';


SELECT * FROM angajati_mcu;

Comanda anterioara executa commit implicit?
R: nu executa commit implicit deoarece este o comanda LMD

commit;

8. Modificaţi tipul de date al coloanei email în VARCHAR2.

DESC angajati_mcu;

ALTER TABLE angajati_mcu
MODIFY (email varchar2(15)); -- cititi observatiile din Laborator 5 - pagina 3


9. Adăugaţi coloana nr_telefon în tabelul ANGAJATI_pnu, setându-i o valoare implicită.

ALTER TABLE angajati_mcu
ADD (nr_telefon varchar2(10) default '0723234234');

SELECT * FROM angajati_mcu;


10. Vizualizaţi înregistrările existente. Suprimaţi coloana nr_telefon.

SELECT * FROM angajati_mcu;

ALTER TABLE angajati_mcu
DROP column nr_telefon;

ROLLBACK; -- ce efect are rollback?

R: rollback nu are efect


11. Creaţi şi tabelul DEPARTAMENTE_mcu, corespunzător schemei relaţionale:

DEPARTAMENTE_pnu (cod_dep# number(2), nume varchar2(15), cod_director number(4))

specificând doar constrângerea NOT NULL pentru nume 
(nu precizaţi deocamdată constrângerea de cheie primară);

CREATE TABLE departamente_mcu
    (cod_dep number(2),
     nume varchar2(15) constraint nume_dep_mcu not null,
     cod_director number(4)
    );
    
DESC departamente_mcu;

SELECT * FROM departamente_mcu;


12. Introduceţi următoarele înregistrări în tabelul DEPARTAMENTE

INSERT INTO departamente_mcu
VALUES (10, 'Administrativ', 100);

INSERT INTO departamente_mcu
VALUES (20, 'Proiectare', 101);

INSERT INTO departamente_mcu
VALUES (30, 'Programare', null);


13. Se va preciza apoi cheia primara cod_dep, fără suprimarea şi recrearea tabelului 
(comanda ALTER);

ALTER TABLE departamente_mcu
ADD CONSTRAINT pkey_dep_mcu PRIMARY KEY(cod_dep);

DESC departamente_mcu;

-- In acest punct mai este nevoie de comanda commit 
-- pentru salvarea celor 3 inserari anterioare?

R: nu, am facut un alter care a comis automat


SELECT * FROM departamente_mcu;
SELECT * FROM angajati_mcu;

DESC departamente_mcu;
DESC angajati_mcu;

14. Să se precizeze constrângerea de cheie externă pentru coloana cod_dep din ANGAJATI_pnu:

a) fără suprimarea tabelului (ALTER TABLE);

ALTER TABLE angajati_mcu
ADD CONSTRAINT fkey_ang_dep foreign key(cod_dep)
REFERENCES departamente_mcu(cod_dep);


b) prin suprimarea şi recrearea tabelului, cu precizarea 
noii constrângeri la nivel de coloană 
({DROP, CREATE} TABLE). 

De asemenea, se vor mai preciza constrângerile (la nivel de coloană, dacă este posibil):
- PRIMARY KEY pentru cod_ang;
- FOREIGN KEY pentru cod_sef;
- UNIQUE pentru combinaţia nume + prenume;
- UNIQUE pentru email;
- NOT NULL pentru nume;
- verificarea cod_dep >0;
- verificarea ca salariul sa fie mai mare decat comisionul*100.

DROP TABLE angajati_mcu;

drop table departamente_mcu;

CREATE TABLE angajati_mcu
    (cod_ang number(4) constraint pkey_ang_mcu primary key,
     nume varchar2(20) constraint nume_ang_mcu not null,
     prenume varchar2(20),
     email char(15) constraint email_unique_mcu unique,
     data_ang date default sysdate,
     job varchar2(10),
     cod_sef number(4) constraint sef_ang_mcu references angajati_pnu(cod_ang), -- cheie externa
     salariu number(8, 2) constraint salariu_ang_mcu not null,
     cod_dep number(2) constraint fk_ang_dept_mcu references departamente_mcu(cod_dep),
     constraint cod_dep_poz check(cod_dep > 0),
     comision number(2,2),
     constraint nume_pren_unice_mcu unique(nume, prenume), 
     constraint verif_sal_mcu check(salariu > 100*comision)
     --constraint pk_compus primary key (col1, col2, ...)
     );
     

15. Suprimaţi şi recreaţi tabelul, specificând toate constrângerile la nivel de tabel (în măsura în care este posibil).


CREATE TABLE ANGAJATI_MCU
    (cod_ang number(4),
    nume varchar2(20) constraint nume_pnu not null,
    prenume varchar2(20),
    email char(15),
    data_ang date default sysdate,
    job varchar2(10),
    cod_sef number(4),
    salariu number(8, 2) constraint salariu_pnu not null,
    cod_dep number(2),
    comision number(2,2),
    constraint nume_prenume_unique_pnu unique(nume,prenume),
    constraint verifica_sal_pnu check(salariu > 100*comision),
    constraint pk_angajati_pnu primary key(cod_ang),
    constraint email_unic unique(email),
    constraint sef_pnu foreign key(cod_sef) references angajati_pnu(cod_ang),
    constraint fk_dep_pnu foreign key(cod_dep) references departamente_pnu (cod_dep),
    constraint cod_dep_poz check(cod_dep > 0)
    );


16. Reintroduceţi date în tabel, utilizând (şi modificând, dacă este necesar) comenzile salvate anterior.

INSERT INTO angajati_mcu
VALUES(100, 'nume1', 'prenume1', 'email1', sysdate, 'Director', null, 20000, 10, 0.1);

INSERT INTO angajati_mcu
VALUES(101, 'nume2', 'prenume2', 'email2', to_date('02-02-2004','dd-mm-yyyy'), 'Inginer', 100, 10000, 10, 0.2);

INSERT INTO angajati_mcu
VALUES(102, 'nume3', 'prenume3', 'email3', to_date('05-06-2000','dd-mm-yyyy'), 'Analist', 101, 5000, 20, 0.1);

INSERT INTO angajati_mcu
VALUES(103, 'nume4', 'prenume4', 'email4', sysdate, 'Inginer', 100, 9000, 20, 0.1);

INSERT INTO angajati_mcu
VALUES(104, 'nume5', 'prenume5', 'email5', sysdate, 'Analist', 101, 3000, 30, 0.1);


-- Ce comanda trebuie executata?

R: _____


19. Introduceţi constrângerea NOT NULL asupra coloanei email.

desc angajati_mcu;

ALTER TABLE angajati_mcu
MODIFY(email not null);


20. (Incercaţi să) adăugaţi o nouă înregistrare în tabelul ANGAJATI_pnu, 
care să corespundă codului de departament 50. Se poate?

INSERT INTO angajati_mcu
VALUES(105, 'nume6', 'prenume6', 'email6', sysdate, 'Analist', 101, 3000, 50, 0.1);

De ce nu se poate insera?

R: ____

SELECT * FROM angajati_mcu;


21. Adăugaţi un nou departament, cu numele Analiza, codul 60 şi 
directorul null în DEPARTAMENTE_pnu. Salvati inregistrarea. 

INSERT INTO departamente_mcu
VALUES (60, 'Analiza', null);

SELECT * FROM departamente_mcu;

COMMIT;


22. (Incercaţi să) ştergeţi departamentul 20 din tabelul DEPARTAMENTE. Comentaţi.

DELETE FROM departamente_mcu
WHERE cod_dep = 20;
-- De ce nu se poate sterge?

R: ____



23. Ştergeţi departamentul 60 din DEPARTAMENTE. ROLLBACK;

DELETE FROM departamente_mcu
WHERE cod_dep = 60;  

-- De ce putem sterge departamentul 60?
R: _____


SELECT * FROM departamente;

ROLLBACK;


24. Se doreşte ştergerea automată a angajaţilor dintr-un departament, odată cu 
suprimarea departamentului. Pentru aceasta, este necesară introducerea clauzei 
ON DELETE CASCADE în definirea constrângerii de cheie externă. 

Suprimaţi constrângerea de cheie externă asupra tabelului ANGAJATI_pnu 
şi reintroduceţi această constrângere, specificând clauza ON DELETE CASCADE.

SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'ANGAJATI_MCU'; -- dorim sa aflam numele constrangerii


-- stergem constrangerea 
ALTER TABLE angajati_mcu
DROP CONSTRAINT FK_DEP_mcu;

--adaugam constrangerea utilizand clauza ON DELETE CASCADE
ALTER TABLE angajati_mcu
ADD CONSTRAINT FK_DEP_MCU FOREIGN KEY(cod_dep)
REFERENCES departamente_mcu(cod_dep) ON DELETE CASCADE;


25. Ştergeţi departamentul 20 din DEPARTAMENTE. Ce se întâmplă? Rollback;

-- Inainte de stergere analizati datele, atat din angajati, cat si din departamente

SELECT * FROM angajati_mcu; 

-- Cati angajati lucreaza in departamentul 20?

R: _____

-- Ce este cod_dep in angajati_pnu?

R: ____

SELECT * FROM departamente_mcu;

-- Ce este cod_dep in departamente_pnu?

R: ____


-- Stergeti departamentul din departamente_pnu si analizati din nou datele din BD

DELETE FROM departamente_mcu
WHERE cod_dep = 20; 

SELECT * FROM departamente_mcu;

SELECT * FROM angajati_mcu; 

-- Ce se intampla daca executam ROLLBACK?

R: ____

ROLLBACK;


26. Introduceţi constrângerea de cheie externă asupra coloanei cod_director 
a tabelului DEPARTAMENTE. 
Se doreşte ca ştergerea unui angajat care este director de departament să atragă după sine 
setarea automată a valorii coloanei cod_director la null.

DESC departamente_mcu;


alter table departamente_mcu
add constraint fk_cod_director foreign key(cod_director)
reference angajati_mcu(cod_ang) on delete set null;



27. Actualizaţi tabelul DEPARTAMENTE, astfel încât angajatul având codul 102 
să devină directorul departamentului 30. 
Ştergeţi angajatul având codul 102 din tabelul ANGAJATI_pnu. 
Analizaţi efectele comenzii. Rollback;

UPDATE departamente_mcu
SET cod_director = 102
WHERE cod_dep = 30;

SELECT * FROM departamente_mcu;

SELECT * FROM angajati_mcu;

DELETE FROM angajati_mcu
WHERE cod_ang = 102; 
      -- avand constrangerea on delete set null pe cheia externa cod_director din departamente
      -- observam ca stergerea angajatului 102 din angajati, 
      -- care era sef de departament in tabelul departamente
      -- a dus la setarea valorii cod_director din tabelul departamente la null

-- Cititi notiunile din Laborator 5 - paginile 4 si 5
-- Studiati exercitiile rezolvate in laborator - exercitiile 28 si 29