create or replace function cancella_operazioni_quota(quota_id integer, nome_partner varchar(20), data timestamp without time zone) returns integer AS $$
declare
    num1 integer;
begin

    delete from operazioni_quote where operazioni_quote.quota_id=$1 and operazioni_quote.nome_partner=$2 and operazioni_quote.data=$3;

    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;