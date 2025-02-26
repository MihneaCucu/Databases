1.Sa se afiseze toate societatile de asigurari care au asigurat timbre emise in anul 1990.
Se vor afisa: codul si numele societatii, codul si numele timbrului, alaturi de
data_emiterii si valoarea acestuia. Timbrele se vor afisa in ordine crescatoare in
functie de valoarea pe care o au.

select sa.cod_asigurator, nume_societate, t.cod_timbru, nume, data_emitere, t.valoare
from soc_asigurare sa join este_asigurat ea on (sa.cod_asigurator = ea.cod_asigurator)
join timbru t on (ea.cod_timbru = t.cod_timbru)
where to_char(data_emitere, 'yyyy') = 1990
order by t.valoare;



2. Pentru fiecare tara sa se afiseze valoarea totala asigurata de asiguratori. Se vor afisa
urmatoarele coloane: cod_asigurator, nume_societate, tara, codul timbrului si valoarea
totala asigurata de asiguratori in tara respectiva.

select sa.cod_asigurator, nume_societate, tara, cod_timbru,
(select sum(valoare)
from este_asigurat x join soc_asigurare y on(x.cod_asigurator =
y.cod_asigurator)
where sa.tara = y.tara
) "Valoare totala"
from soc_asigurare sa join este_asigurat ea on (sa.cod_asigurator =
ea.cod_asigurator);

3.Sa se obtina numele celor mai buni 2 vanzatori din punct de vedere al numarului de
timbre vandute.

select nume
from (select vanz.cod_vanzator, nume, count(cod_timbru)
from vinde vin join vanzator vanz on (vin.cod_vanzator = vanz.cod_vanzator)
group by vanz.cod_vanzator, nume
order by 3 desc
)
where rownum <= 2

4. Sa se scrie o cerere care afiseaza numele vanzatorilor si valoarea totala de cumparare
a timbrelor pentru fiecare vanzator in parte. Se vor considera doar acei vanzatori a
caror valoare totala de cumparare a timbrelor este mai mare decat media valorilor
totale de cumparare pentru fiecare vanzator in parte.

with valoare_totala as (select vanz.cod_vanzator, vanz.nume, sum(val_cumparare)
suma
from vinde vin join vanzator vanz
on (vin.cod_vanzator = vanz.cod_vanzator)
group by vanz.cod_vanzator, vanz.nume
),
vanzatori as (select nume, suma
from valoare_totala
where suma > (select round(avg(suma))
from valoare_totala)
)
select *
from vanzatori;


5. Sa se obtina societatile de asigurari care au asigurat toate timbrele emise in anul 1990.
Societatile pot asigura si alte timbre, dar obligatoriu trebuie sa asigure toate timbrele
emise in 1990.

select cod_asigurator
from este_asigurat
where cod_timbru IN (select cod_timbru
from timbru
where to_char(data_emitere, 'yyyy') = 1990
)
group by cod_asigurator
having count(cod_timbru) = (select count(cod_timbru)
from timbru
where to_char(data_emitere, 'yyyy') = 1990
);

6. Sa se obtina valoarea totala si numarul timbrelor care au fost achizitionate in anul
2020 si au fost vandute pentru o valoare egala cu valoarea lor reala (val_pornire =
val_cumparare).

select sum(t.valoare), count(t.cod_timbru)
from timbru t join vinde v on (t.cod_timbru = v.cod_timbru)
where val_pornire = val_cumparare and to_char(data_achizitie, 'yyyy') = 2020;

7. Creati tabelul “valoare_totala_PNU” care sa contina numele timbrului, numele
vanzatorului si numarul total de timbre vandute pentru fiecare timbru in parte.

select t.nume, vanz.nume, (select count(*)
from vinde
where cod_timbru = t.cod_timbru
) "Timbre vandute"
from timbru t join vinde vin on (t.cod_timbru = vin.cod_timbru)
join vanzator vanz on (vin.cod_vanzator = vanz.cod_vanzator);
desc timbru;
desc vanzator;
create table valoare_totala
(nume_timbru varchar2(30),
nume_vanzator varchar2(30),
numar_total_timbre number(5)
);

insert into valoare_totala
(select t.nume, vanz.nume, (select count(*)
from vinde
where cod_timbru = t.cod_timbru
) "Timbre vandute"
from timbru t join vinde vin on (t.cod_timbru = vin.cod_timbru)
join vanzator vanz on (vin.cod_vanzator = vanz.cod_vanzator)
);
select * from valoare_totala;