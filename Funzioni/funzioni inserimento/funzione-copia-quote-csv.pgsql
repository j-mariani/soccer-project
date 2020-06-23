create or replace function copia_quote_csv() returns integer as $$
declare
    su varchar(60);
    tbl varchar(10);
    tbl2 varchar(10);
    it record;
    it2 integer;
    query varchar(100);
begin
    su = session_user;
    it2 = 0;
    tbl = left(su,-6);
    tbl2 = tbl || 'H';
    query = 'select "' || tbl2 || '" as p1,match_id from bet where "' || tbl2 || '" is not null';
    for it in execute query
    loop
        insert into quote(valore,incontro_id,vittoria) values (it.p1,it.match_id,'casa');
        it2 = it2 + 1;
    end loop;
    tbl2 = tbl || 'D';
        query = 'select "' || tbl2 || '" as p1,match_id from bet where "' || tbl2 || '" is not null';
    for it in execute query
    loop
        insert into quote(valore,incontro_id,vittoria) values (it.p1,it.match_id,'pareggio');
        it2 = it2 + 1;
    end loop;
    tbl2 = tbl || 'A';
        query = 'select "' || tbl2 || '" as p1,match_id from bet where "' || tbl2 || '" is not null';
    for it in execute query
    loop
        insert into quote(valore,incontro_id,vittoria) values (it.p1,it.match_id,'trasferta');
        it2 = it2 + 1;
    end loop;
    --insert into quote (incontro_id,valore,vittoria) select match_id,"IWA",'trasferta' from bet where "IWA" is not null;
    return it2;
END;
$$ LANGUAGE plpgsql;

