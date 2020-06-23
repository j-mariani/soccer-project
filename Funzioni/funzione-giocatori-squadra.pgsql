create or replace function giocatori_squadra(squadra integer) returns table(id integer) AS $$
declare

    pos gioca.posizione%type;
    gioc gioca.giocatore_id%type;
    ic_id gioca.incontro_id%type;
    squad squadre.id%type;
    
begin
    DROP TABLE IF EXISTS temp_t;    
    CREATE TEMP TABLE if not exists temp_t AS SELECT gioca.giocatore_id,squadre.id as squadra FROM incontri join squadre on squadra_casa=squadre.id join gioca on incontro_id=incontri.id limit 0;

    for gioc in select giocatori.id from giocatori
    loop
        select posizione into pos from gioca join incontri on incontro_id = incontri.id where gioca.giocatore_id=gioc order by data desc,incontri.id desc limit 1;
        if(pos = 'casa') then
            select squadra_casa into squad from gioca join incontri on incontro_id = incontri.id where gioca.giocatore_id=gioc order by data desc,incontri.id desc limit 1;
            insert into temp_t(giocatore_id,squadra) values (gioc,squad);
        end if;
        if(pos = 'trasferta') then
            select squadra_trasferta into squad from gioca join incontri on incontro_id = incontri.id where gioca.giocatore_id=gioc order by data desc,incontri.id desc limit 1;
            insert into temp_t(giocatore_id,squadra) values (gioc,squad);
        end if; 

    end loop;
    return query 
    select temp_t.giocatore_id from temp_t where temp_t.squadra=$1;
    end;
$$ language plpgsql security definer;