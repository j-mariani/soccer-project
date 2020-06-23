create or replace function inserisci_quota(valore numeric,vittoria varchar(9),incontro_id integer) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(quote.id) into num1 from quote;
    INSERT INTO quote(valore,vittoria,incontro_id) values ($1,$2,$3) on conflict do nothing ;
    select count(quote.id) into num2 from quote;
    return num2-num1;
end;
$$ language plpgsql;