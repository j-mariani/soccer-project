create or replace function quote_modificabili() returns table(quota_id integer,incontro_id integer,valore numeric, vittoria varchar(9)) AS $$
begin
    return query
    select quote.id,quote.incontro_id,quote.valore,quote.vittoria from operazioni_quote join quote on operazioni_quote.quota_id=quote.id where nome_partner=session_user order by quote.incontro_id;
    end
$$ language plpgsql security definer;