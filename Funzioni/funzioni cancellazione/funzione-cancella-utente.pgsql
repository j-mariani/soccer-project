create or replace function cancella_utente(nome_utente varchar(20)) returns integer AS $$
declare
    num1 integer;
    num2 integer;
    num3 integer;

begin
    if EXISTS(select * from operatori where operatori.nome_utente=$1 union select * from amministratori where amministratori.nome_utente=$1 union select partner.nome_utente,partner.password from partner where partner.nome_utente=$1) then
        delete from operatori where operatori.nome_utente=$1 ;
        GET DIAGNOSTICS num1 = ROW_COUNT;

        delete from amministratori where amministratori.nome_utente=$1;
        GET DIAGNOSTICS num2 = ROW_COUNT;

        delete from partner where partner.nome_utente=$1;
        GET DIAGNOSTICS num3 = ROW_COUNT;
        EXECUTE FORMAT('drop USER %I', $1);
    end if;

    return num1+num2+num3;
end;
$$ language plpgsql;

