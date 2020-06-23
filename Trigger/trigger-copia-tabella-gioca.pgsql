create or replace function aggiungi_dati_gioca() returns trigger as $$
declare
    gioc temp_gioca%rowtype;

begin
    for gioc in select * from temp_gioca
    loop
        insert into gioca(giocatore_id,incontro_id,posizione) values (gioc.giocatore_id,gioc.incontro_id,gioc.posizione) on conflict do nothing;
    end loop;
    delete from temp_gioca *;
    return null;
end;
$$ LANGUAGE plpgsql security definer;

create TRIGGER update_gioca after insert on temp_gioca execute procedure aggiungi_dati_gioca();
