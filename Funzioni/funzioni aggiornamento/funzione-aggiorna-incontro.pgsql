create or replace function aggiorna_incontro(id integer, data timestamp without time zone default null, goal_casa integer default null, goal_trasferta integer default null, lega varchar(50) default null, squadra_casa integer default null, squadra_trasferta integer default null, nuovo_id integer default null) returns integer AS $$
declare
    num1 integer;
begin
    if(session_user = 'admin') then
        update incontri set
            id=coalesce($8,incontri.id), 
            data=coalesce($2,incontri.data),
            goal_casa=coalesce($3,incontri.goal_casa),
            goal_trasferta=coalesce($4,incontri.goal_trasferta),
            lega=coalesce($5,incontri.lega),
            squadra_casa=coalesce($6,incontri.squadra_casa),
            squadra_trasferta=coalesce($7,incontri.squadra_trasferta) 
        where incontri.id=$1;
    else
        update incontri set
            data=coalesce($2,incontri.data),
            goal_casa=coalesce($3,incontri.goal_casa),
            goal_trasferta=coalesce($4,incontri.goal_trasferta),
            lega=coalesce($5,incontri.lega),
            squadra_casa=coalesce($6,incontri.squadra_casa),
            squadra_trasferta=coalesce($7,incontri.squadra_trasferta) 
        where incontri.id=$1;
    end if;
    
    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;