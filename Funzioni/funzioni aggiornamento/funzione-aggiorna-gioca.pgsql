create or replace function aggiorna_gioca(giocatore_id integer,incontro_id integer,nuovo_giocatore_id integer default null) returns integer AS $$
declare
    num1 integer;
    sq integer;
    ris integer;
    pos varchar(9);
begin
    ris = 0;
    select gioca.posizione into pos from gioca where gioca.giocatore_id=$1 and gioca.incontro_id=$2;
    if(pos = 'casa') then
        select incontri.squadra_casa into sq from incontri where id=$2 ;
        select count(id) into ris from giocatori_squadra(sq) where id=$3;
    end if;
    if(pos = 'trasferta') then  
        select incontri.squadra_trasferta into sq from incontri where id=$2 ;
        select count(id) into ris from giocatori_squadra(sq) where id=$3;
    end if;
    if(ris > 0) then
        update gioca set
            giocatore_id=coalesce($3,gioca.giocatore_id) 
        where gioca.giocatore_id=$1 and gioca.incontro_id=$2;
        GET DIAGNOSTICS num1 = ROW_COUNT;
    else
        num1=0;
    end if;
    return num1;
end;
$$ language plpgsql;