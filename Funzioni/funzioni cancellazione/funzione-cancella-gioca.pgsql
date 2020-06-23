create or replace function cancella_gioca(giocatore_id integer,incontro_id integer) returns integer AS $$
declare
    num1 integer;

begin
    delete from gioca where gioca.giocatore_id=$1 and gioca.incontro_id=$2;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;