create or replace function cancella_giornata(numero integer, stagione varchar(9)) returns integer AS $$
declare
    num1 integer;
begin

    delete from giornate where giornate.numero=$1 and giornate.stagione=$2;

    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;