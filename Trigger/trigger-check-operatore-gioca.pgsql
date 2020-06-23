create or replace function controllo_permessi_operatore_gioca() returns trigger as $$
declare
    ic_id gioca.incontro_id%type;
    usr operazioni_incontri.nome_operatore%type;
begin
    if(TG_OP = 'DELETE') THEN
        ic_id = old.incontro_id;
    else
        ic_id = NEW.incontro_id;
    end if;
    if EXISTS(select nome_operatore from operazioni_incontri join incontri on incontri.id = operazioni_incontri.incontro_id join operatori on nome_operatore=nome_utente where incontro_id=ic_id) then
        select nome_operatore into usr from operazioni_incontri join incontri on incontri.id = operazioni_incontri.incontro_id join operatori on nome_operatore=nome_utente where incontro_id=ic_id;
        if(usr = session_user) THEN
            if(TG_OP = 'DELETE') THEN
                return old;
            end if;
            return new;
        else
            if EXISTS(select nome_utente from amministratori where nome_utente=session_user) then 
                if(TG_OP = 'DELETE') THEN
                    return old;
                end if;
                return new;
            elsif(session_user='admin') then 
                if(TG_OP = 'DELETE') THEN
                    return old;
                end if;
                return new;
            else 
                raise exception 'Non sei l` utente autorizzato a gestire l` incontro_id %', ic_id;
            end if;
        end if;
    ELSE
        if(TG_OP = 'DELETE') THEN
            return old;
        end if;
        return NEW;
    end if; 
END;
$$ LANGUAGE plpgsql security definer;

create TRIGGER check_operazioni_operatore_gioca before insert or update or delete on gioca for each row execute procedure controllo_permessi_operatore_gioca();
