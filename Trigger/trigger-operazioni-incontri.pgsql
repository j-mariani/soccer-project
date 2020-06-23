create or replace function aggiungi_operazioni_incontri() returns trigger as $$
begin
    if EXISTS(select nome_utente from amministratori where nome_utente=session_user) then
        return null;
    elsif(session_user='admin') then
        return null;
    else
        insert into operazioni_incontri(incontro_id,nome_operatore) values (new.id,session_user);
    end if;

    return null;
END;
$$ LANGUAGE plpgsql security definer;

create TRIGGER update_operazioni_incontri after insert or update on incontri for each row execute procedure aggiungi_operazioni_incontri();
