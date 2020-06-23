create or replace function controllo_permessi_partner() returns trigger as $$
declare
    ic_id quote.incontro_id%type;
    q_id quote.id%type;
    usr_soc partner.societa%TYPE;
    usr_soc_nome societa.nome%type;
    rslt2 record;
    flag BOOLEAN;
begin
    if(TG_OP != 'INSERT') THEN
        q_id = old.id;
    else
        ic_id = NEW.incontro_id;
    end if;
    select societa,nome into usr_soc,usr_soc_nome from partner join societa on societa=id where nome_utente=session_user;
    if EXISTS(select * from operazioni_quote join quote on quote.id = operazioni_quote.quota_id join partner on nome_partner=nome_utente where incontro_id=ic_id and societa=usr_soc) then
        for rslt2 in select * from operazioni_quote join quote on quote.id = operazioni_quote.quota_id join partner on nome_partner=nome_utente where incontro_id=ic_id and societa=usr_soc
        loop
            if(rslt2.nome_partner = session_user) THEN
                if(rslt2.vittoria = new.vittoria and tg_op = 'INSERT') THEN
                    raise exception 'Quota incontro_id % vincita % già presente per societa %', ic_id, new.vittoria, usr_soc_nome;
                end if;
                flag=true;
            else
                if (session_user='admin') then
                    flag=true;
                else
                    flag=false;
                end if;
            end if;
        end loop;
        if  (flag) THEN
            if(TG_OP='DELETE') then
                return old;
            end if;
            return new;
        ELSE
            raise exception 'Non sei l` utente autorizzato a gestire le quote per l` incontro_id % per la societa %', ic_id, usr_soc_nome;
        end if;
    ELSE
        if(TG_OP!='INSERT') then
            if EXISTS(select * from operazioni_quote where operazioni_quote.quota_id = q_id and operazioni_quote.nome_partner = session_user) then
                if(TG_OP='DELETE') then
                    return old;
                else
                    if EXISTS(select * from quote_modificabili() as c where c.incontro_id=old.incontro_id and c.vittoria=new.vittoria) then
                        raise exception 'Quota incontro_id % vincita % già presente per societa %', old.incontro_id, new.vittoria, usr_soc_nome;
                    end if;
                    return new;
                end if;
            else
                if(session_user = 'admin') then
                    if(TG_OP='DELETE') then
                        return old;
                    else
                        return new;
                    end if;
                end if;
                if EXISTS(select nome_utente from amministratori where nome_utente=session_user) then
                    if(TG_OP='DELETE') then
                        return old;
                    else
                        return new;
                    end if;
                end if;
                if EXISTS(select nome_utente from operatori where nome_utente=session_user) then
                    if(TG_OP='DELETE') then
                        return old;
                    else
                        return new;
                    end if;
                end if;
                raise exception 'Non sei l` utente autorizzato a gestire la quota %', q_id;
            end if;
        end if;
        return NEW;
    end if; 
END;
$$ LANGUAGE plpgsql security definer;

create TRIGGER check_operazioni_partner before insert or update or delete on quote for each row execute procedure controllo_permessi_partner();
