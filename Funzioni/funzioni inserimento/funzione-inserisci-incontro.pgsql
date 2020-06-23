create or replace function inserisci_incontro(id integer, data timestamp without time zone, goal_casa integer, goal_trasferta integer, lega varchar(50), squadra_casa integer, squadra_trasferta integer) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(incontri.id) into num1 from incontri;
    INSERT INTO incontri(id,data,goal_casa,goal_trasferta,lega,squadra_casa,squadra_trasferta) values ($1,$2,$3,$4,$5,$6,$7) on conflict do nothing;
    select count(incontri.id) into num2 from incontri;
    return num2-num1;
end;
$$ language plpgsql;