create or replace function aggiorna_partner(nome_utente varchar(20),tipo_operazione integer, password varchar(20) default null,nuovo_nome_utente varchar(20) default null,societa integer default null) returns integer AS $$
declare
    num1 integer;

    pass varchar(80);
    p2 text;
    nu varchar(20);
    nnu varchar(20);
    ck varchar(20);
    rcd record;
begin
    p2 = password;
    nu = nome_utente;
    nnu = nuovo_nome_utente;
    SELECT ENCODE(DIGEST(p2,'sha256'),'hex') into pass where p2 is not null;
    select regexp_replace(nnu, '[^a-zA-Z0-9_-]', '', 'g') into ck;
    if(tipo_operazione = 1) then
        update partner set 
            password=coalesce(pass,partner.password)
        where partner.nome_utente=nu;
        GET DIAGNOSTICS num1 = ROW_COUNT;
        EXECUTE FORMAT('alter USER %I PASSWORD %L', nu,p2);
    elsif(tipo_operazione = 2) then
        if EXISTS (select coalesce from coalesce(pass) where coalesce is not null) then
            if(ck = nnu) then
                update partner set
                    nome_utente = coalesce(ck,partner.nome_utente),
                    password = coalesce(pass,partner.password)
                where partner.nome_utente=nu;
                GET DIAGNOSTICS num1 = ROW_COUNT;
                
                EXECUTE FORMAT('alter USER %I rename to %I', nu,ck);
                EXECUTE FORMAT('alter USER %I PASSWORD %L', ck,p2);

            else
                raise notice 'Solo lettere minuscole/maiuscole, numeri, _ o - sono ammessi';
            end if;
        end if;
    elsif(tipo_operazione=3) then
        for rcd in select * from operazioni_quote where nome_partner=nu
        loop
            delete from quote where id=rcd.quota_id;
        end loop;
        update partner set 
            societa=coalesce($5,partner.societa)
        where partner.nome_utente=nu;

        GET DIAGNOSTICS num1 = ROW_COUNT;
    end if;

    return num1;
end;
$$ language plpgsql;

