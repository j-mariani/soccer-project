create or replace function aggiungi_operazioni_quote() returns trigger as $$
begin
    if (session_user='admin') then
        return null;
    else
        insert into operazioni_quote(quota_id,nome_partner) values (new.id,session_user);
    end if;
    return null;
END;
$$ LANGUAGE plpgsql security definer;

create TRIGGER update_operazioni_quote after insert or update on quote for each row execute procedure aggiungi_operazioni_quote();
