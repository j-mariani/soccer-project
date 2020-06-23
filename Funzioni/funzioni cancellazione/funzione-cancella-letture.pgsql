create or replace function cancella_letture(giocatore_id integer, data timestamp without time zone) returns integer AS $$
declare
    num1 integer;

begin
    delete from letture_attributi_giocatori where letture_attributi_giocatori.giocatore_id=$1 and letture_attributi_giocatori.data=$2; 
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;

