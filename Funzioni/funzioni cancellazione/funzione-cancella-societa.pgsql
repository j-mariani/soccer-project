create or replace function cancella_societa(id integer) returns integer AS $$
declare
    num1 integer;
begin

    delete from societa where societa.id=$1;

    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;