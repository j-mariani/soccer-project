create or replace function cancella_squadra(id integer) returns integer AS $$
declare
    num1 integer;
begin
    delete from squadre where squadre.id=$1;
    
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;