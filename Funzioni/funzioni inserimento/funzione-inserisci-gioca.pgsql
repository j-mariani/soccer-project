create or replace function inserisci_gioca(giocatore_id integer,incontro_id integer, posizione varchar(9)) returns integer AS $$
declare
    num1 integer;
    num2 integer;

begin
    select count(gioca.giocatore_id) into num1 from gioca;
    INSERT INTO gioca(giocatore_id,incontro_id,posizione) values ($1,$2,$3) on conflict do nothing ;
    select count(gioca.giocatore_id) into num2 from gioca;
    return num2-num1;
end;
$$ language plpgsql;