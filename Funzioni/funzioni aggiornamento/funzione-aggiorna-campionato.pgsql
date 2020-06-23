create or replace function aggiorna_campionato(incontro_id integer, giornata integer default null, stagione varchar(9) default null, nuovo_incontro_id integer default null) returns integer AS $$
declare
    num1 integer;
begin

    update campionati set
        incontro_id=coalesce($4,campionati.incontro_id), 
        giornata=coalesce($2,campionati.giornata),
        stagione=coalesce($3,campionati.stagione)
    where campionati.incontro_id=$1;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;