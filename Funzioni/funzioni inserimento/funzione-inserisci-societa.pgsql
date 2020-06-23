create or replace function inserisci_societa(id integer, nome varchar(10)) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(societa.id) into num1 from societa;
    INSERT INTO societa(id,nome) values ($1,$2) on conflict do nothing;
    select count(societa.id) into num2 from societa;
    return num2-num1;
end;
$$ language plpgsql;