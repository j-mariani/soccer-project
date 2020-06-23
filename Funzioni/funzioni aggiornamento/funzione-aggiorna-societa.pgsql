create or replace function aggiorna_societa(id integer, nome varchar(10) default null, nuovo_id integer default null) returns integer AS $$
declare
    num1 integer;
begin

    update societa set
        id=coalesce($3,societa.id), 
        nome=coalesce($2,societa.nome)
    where societa.id=$1;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;