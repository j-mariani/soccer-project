create or replace function cancella_lega(nome varchar(50)) returns integer AS $$
declare
    num1 integer;
begin
    delete from leghe where leghe.nome=$1;
    
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;