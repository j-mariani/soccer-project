create or replace function inserisci_giornata(numero integer, stagione varchar(9)) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(giornate.numero) into num1 from giornate;
    INSERT INTO giornate(numero,stagione) values ($1,$2) on conflict do nothing ;
    select count(giornate.numero) into num2 from giornate;
    return num2-num1;
end;
$$ language plpgsql;