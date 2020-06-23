create or replace function aggiorna_squadra(id integer, nome varchar(3) default null, nome_lungo varchar(40) default null, nuovo_id integer default null) returns integer AS $$
declare
    num1 integer;
begin
    update squadre set 
        id=coalesce($4,squadre.id),
        nome=coalesce($2,squadre.nome),
        nome_lungo=coalesce($3,squadre.nome_lungo)
    where squadre.id=$1;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;