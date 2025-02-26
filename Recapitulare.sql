1.

select sa.cod_asigurator, nume_societate, tara, t.cod_timbru, nume, data_emitere, t.valoare
from soc_asigurare sa join este_asigurat ea on (sa.cod_asigurator = ea.cod_asigurator)
                    join timbru t on (ea.cod_timbru = t.cod_timbru)
                    
where to_char(data_emitere, 'yyyy') = '1990'
order by t.valoare;


2.

select sa.cod_asigurator, nume_societate, tara, cod_timbru, (select sum(valoare)
from este_asigurat x join soc_asigurare y on (x.cod_asigurator = y.cod_asigurator)
where sa.tara = y.tara) "Valoare totala"
from soc_asigurare sa join este_asigurat ea on (sa.cod_asigurator = ea.cod_asigurator);

3.

select nume
from (select vanz.cod_vanzator, nume, count(cod_timbru)
    from vinde vin join vanzator vanz on (vin.cod_vanzator = vanz.cod_vanzator)
    group by vanz.cod_vanzator, nume
    order by 3 desc)
where rownum <=2;


4.

with valoare_totala as (select vanz.cod_vanzator, vanz.nume, sum(val_cumparare) suma
                        from vinde vin join vanzator vanz
                        on(vin.cod_vanzator = vanz.cod_vanzator)
                        group by vanz.cod_vanzator, vanz.nume),

vanzatori as (select nume, suma
                    from valoare_totala
                    where suma > (select round(avg(suma))
                                from valoare_totala)
                    )
                    
select * from vanzatori;   
                    
                    
5.

select cod_asigurator
from este_asigurat
where cod_timbru in (select cod_timbru
                    from timbru
                    where to_char(data_emitere, 'yyyy') = '1990')
group by cod_asigurator
having count(cod_timbru) = (select count(cod_timbru)
                            from timbru
                            where to_char(data_emitere, 'yyyy') = '1990');
                            
                            
6.

select cod_asigurator
from este_asigurat
where cod_timbru in
    (select distinct cod_timbru
    from vinde 
    where to_char(data_achizitie, 'yyyy') =
                                            (select to_char(data_achizitie, 'yyyy')
                                            from vinde
                                            where val_pornire = val_cumparare
                                            group by to_char(data_achizitie, 'yyyy')
                                            having count(cod_timbru) = (select max(count(cod_timbru))
                                                        from vinde
                                                        where val_pornire = val_cumparare
                                                        group by to_char(data_achizitie, 'yyyy')
                                                        )
                                            )
    )
    
group by cod_asigurator
having count(cod_timbru) = 
       (select count(distinct cod_timbru)
    from vinde 
    where to_char(data_achizitie, 'yyyy') =
                                            (select to_char(data_achizitie, 'yyyy')
                                            from vinde
                                            where val_pornire = val_cumparare
                                            group by to_char(data_achizitie, 'yyyy')
                                            having count(cod_timbru) = (select max(count(cod_timbru))
                                                        from vinde
                                                        where val_pornire = val_cumparare
                                                        group by to_char(data_achizitie, 'yyyy')
                                                        )
                                            )
    ); 
          
          
          
          
7.

select t.nume, vanz.nume, (select count(*)
                            from vinde
                            where cod_timbru = t.cod_timbru
                            ) "Timbre vandute"
from timbru t join vinde vin on (t.cod_timbru = vin.cod_timbru)
                join vanzator vanz on (vin.cod_vanzator = vanz.cod_vanzator);
                
                
                
desc timbru;
desc vanzator;


create table valoare_totala_mcu
            (nume_timbru varchar2(30),
            nume_vanzator varchar2(30),
            numar_totala_timbre number(5)
            );
            
insert into valoare_totala_mcu
    (select t.nume, vanz.nume, (select count(*)
                                from vinde 
                                where cod_timbru = t.cod_timbru
                                ) "Timbre vandute"
from timbru t join vinde vin on (t.cod_timbru = vin.cod_timbru)
            join vanzator vanz on (vin.cod_vanzator = vanz.cod_vanzator)
    );
    
    
select * from valoare_totala_mcu;