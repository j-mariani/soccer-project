create or replace function inserisci_lega(nome varchar(50), nazione varchar(10)) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(leghe.nome) into num1 from leghe;
    INSERT INTO leghe(nome,nazione) values ($1,$2) on conflict do nothing ;
    select count(leghe.nome) into num2 from leghe;
    return num2-num1;
end;
$$ language plpgsql;