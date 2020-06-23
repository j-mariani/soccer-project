create or replace function inserisci_campionato(incontro_id integer, giornata integer, stagione varchar(9)) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(campionati.incontro_id) into num1 from campionati;
    INSERT INTO campionati(incontro_id,giornata,stagione) values ($1,$2,$3) on conflict do nothing ;
    select count(campionati.incontro_id) into num2 from campionati;
    return num2-num1;
end;
$$ language plpgsql;