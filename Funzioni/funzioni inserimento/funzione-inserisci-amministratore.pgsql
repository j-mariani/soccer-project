create or replace function inserisci_amministratore(nome_utente varchar(20), password varchar(20)) returns integer AS $$
declare
    num1 integer;
    num2 integer;
    pass varchar(80);
    p2 text;
    ck varchar(20);
begin
    p2 = $2;
    select count(amministratori.nome_utente) into num1 from amministratori;
    SELECT ENCODE(DIGEST($2,'sha256'),'hex') into pass;
    select regexp_replace($1, '[^a-zA-Z0-9_-]', '', 'g') into ck;
    if(ck = $1) then
        EXECUTE FORMAT('CREATE USER %I IN ROLE amministratore PASSWORD %L', $1,p2);
        INSERT INTO amministratori(nome_utente,password) values ($1,pass) on conflict do nothing ;
    else
        raise notice 'Solo lettere minuscole/maiuscole, numeri, _ o - sono ammessi';
    end if;
    select count(amministratori.nome_utente) into num2 from amministratori;
    return num2-num1;
end;
$$ language plpgsql strict;

