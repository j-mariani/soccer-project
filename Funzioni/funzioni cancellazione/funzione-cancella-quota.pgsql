create or replace function cancella_quota(id integer) returns integer AS $$
declare
    num1 integer;
begin
    delete from quote where quote.id=$1;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;