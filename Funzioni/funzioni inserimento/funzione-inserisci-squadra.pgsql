create or replace function inserisci_squadra(id integer, nome varchar(3), nome_lungo varchar(40)) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(squadre.id) into num1 from squadre;
    INSERT INTO squadre(id,nome,nome_lungo) values ($1,$2,$3) on conflict do nothing ;
    select count(squadre.id) into num2 from squadre;
    return num2-num1;
end;
$$ language plpgsql;