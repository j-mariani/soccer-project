create or replace function aggiorna_amministratore(nome_utente varchar(20),tipo_operazione integer, password varchar(20),nuovo_nome_utente varchar(20) default null) returns integer AS $$
declare
    num1 integer;

    pass varchar(80);
    p2 text;
    nu varchar(20);
    nnu varchar(20);
    ck varchar(20);
begin
    p2 = password;
    nu = nome_utente;
    nnu = nuovo_nome_utente;
    SELECT ENCODE(DIGEST(p2,'sha256'),'hex') into pass where p2 is not null;
    select regexp_replace(nnu, '[^a-zA-Z0-9_-]', '', 'g') into ck;
    if(tipo_operazione = 1) then
        update amministratori set 
            password=coalesce(pass,amministratori.password)
        where amministratori.nome_utente=nu;
        GET DIAGNOSTICS num1 = ROW_COUNT;
        EXECUTE FORMAT('alter USER %I PASSWORD %L', nu,p2);
    elsif(tipo_operazione = 2) then
        if EXISTS (select coalesce from coalesce(pass) where coalesce is not null) then
            if(ck = nnu) then
                update amministratori set
                    nome_utente = coalesce(ck,amministratori.nome_utente),
                    password = coalesce(pass,amministratori.password)
                where amministratori.nome_utente=nu;
                GET DIAGNOSTICS num1 = ROW_COUNT;
                
                EXECUTE FORMAT('alter USER %I rename to %I', nu,ck);
                EXECUTE FORMAT('alter USER %I PASSWORD %L', ck,p2);

            else
                raise notice 'Solo lettere minuscole/maiuscole, numeri, _ o - sono ammessi';
            end if;
        end if;
    end if;

    return num1;
end;
$$ language plpgsql;

