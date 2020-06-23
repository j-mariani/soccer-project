create or replace function punteggi_lega() returns table(lega varchar(50), squadra integer, punteggio integer,stagione varchar(9)) as $$
declare 
    sqd record;
begin

    CREATE TEMP TABLE risultati (
    lega varchar(50),
    squadra integer,
    punteggio integer,
    stagione varchar(9)
    ) on commit drop ;
    
    for sqd in select count(vittorie.incontro_id),vittorie.squadra,campionati.stagione,incontri.lega from vittorie join campionati on vittorie.incontro_id=campionati.incontro_id join incontri on incontri.id=vittorie.incontro_id group by vittorie.squadra,campionati.stagione,incontri.lega
    loop
        insert into risultati(lega,squadra,punteggio,stagione) values (sqd.lega,sqd.squadra,sqd.count*3,sqd.stagione);
    end loop;
    for sqd in select pareggi.squadra_casa,pareggi.squadra_trasferta,campionati.stagione,pareggi.incontro_id,incontri.lega from pareggi join campionati on pareggi.incontro_id=campionati.incontro_id join incontri on incontri.id=pareggi.incontro_id
    loop
        if exists(select * from risultati where risultati.squadra=sqd.squadra_casa and risultati.stagione=sqd.stagione and risultati.lega=sqd.lega) then
            update risultati set punteggio=risultati.punteggio+1 where risultati.squadra=sqd.squadra_casa and risultati.stagione=sqd.stagione and risultati.lega=sqd.lega;
        else
            insert into risultati(lega,squadra,punteggio,stagione) values (sqd.lega,sqd.squadra_casa,1,sqd.stagione);
        end if;
        if exists(select * from risultati where risultati.squadra=sqd.squadra_trasferta and risultati.stagione=sqd.stagione and risultati.lega=sqd.lega) then
            update risultati set punteggio=risultati.punteggio+1 where risultati.squadra=sqd.squadra_trasferta and risultati.stagione=sqd.stagione and risultati.lega=sqd.lega;
        else
            insert into risultati(lega,squadra,punteggio,stagione) values (sqd.lega,sqd.squadra_trasferta,1,sqd.stagione);
        end if;
    end loop;
    return query select * from risultati order by lega,stagione,punteggio desc;
end;
$$ language plpgsql security definer;