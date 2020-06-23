create or replace function aggiorna_giornata(numero integer, stagione varchar(9),nuovo_numero integer default null, nuova_stagione varchar(9) default null) returns integer AS $$
declare
    num1 integer;
begin

    update giornate set
        numero=coalesce($3,giornate.numero), 
        stagione=coalesce($4,giornate.stagione)
    where giornate.numero=$1 and giornate.stagione=$2;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;