create or replace function cancella_campionato(incontro_id integer) returns integer AS $$
declare
    num1 integer;
begin
    delete from campionati where campionati.incontro_id=$1;
    
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;