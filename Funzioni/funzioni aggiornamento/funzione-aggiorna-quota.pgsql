create or replace function aggiorna_quota(id integer, valore numeric default null,vittoria varchar(9) default null,incontro_id integer default null, nuovo_id integer default null) returns integer AS $$
declare
    num1 integer;
begin
    if(session_user = 'admin') then
        update quote set
            id=coalesce($5,quote.id), 
            valore=coalesce($2,quote.valore),
            vittoria=coalesce($3,quote.vittoria),
            incontro_id=coalesce($4,quote.incontro_id)
        where quote.id=$1;
    else
        update quote set
            valore=coalesce($2,quote.valore),
            vittoria=coalesce($3,quote.vittoria)
        where quote.id=$1;
    end if;
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;