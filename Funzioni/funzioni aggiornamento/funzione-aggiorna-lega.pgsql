create or replace function aggiorna_lega(nome varchar(50), nazione varchar(10) default null, nuovo_nome varchar(50) default null) returns integer AS $$
declare
    num1 integer;
begin
    update leghe set 
        nome=coalesce($3,leghe.nome),
        nazione=coalesce($2,leghe.nazione)
    where leghe.nome=$1;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;