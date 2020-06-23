create or replace function aggiungi_dati_incontri() returns trigger as $$
declare
    mtch match%rowtype;

begin
    for mtch in select * from match
    loop
        insert into squadre(id,nome,nome_lungo) values (mtch.home_team_id,mtch.home_team_short_name,mtch.home_team_long_name) on conflict do nothing;
        insert into squadre(id,nome,nome_lungo) values (mtch.away_team_id,mtch.away_team_short_name, mtch.away_team_long_name) on conflict do nothing;
        insert into leghe(nome,nazione) values (mtch.league_name,mtch.country_name) on conflict do nothing;
        insert into giornate(stagione,numero) values (mtch.season,mtch.stage) on conflict do nothing;
        insert into incontri(id,data,goal_casa,goal_trasferta,squadra_casa,squadra_trasferta,lega) values (mtch.id,to_timestamp(mtch.date,'YYYY-MM-DD HH24:MI:SS'),mtch.home_team_goal,mtch.away_team_goal,mtch.home_team_id,mtch.away_team_id,mtch.league_name) on conflict do nothing;
        insert into campionati(incontro_id,giornata,stagione) values (mtch.id,mtch.stage,mtch.season) on conflict do nothing;
        if max(coalesce(mtch.home_player_1_id,0)) > 0 then 
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_1_id,mtch.home_player_1_name,mtch.home_player_1_weight,to_timestamp(mtch.home_player_1_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_1_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_1_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_2_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_2_id,mtch.home_player_2_name,mtch.home_player_2_weight,to_timestamp(mtch.home_player_2_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_2_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_2_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_3_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_3_id,mtch.home_player_3_name,mtch.home_player_3_weight,to_timestamp(mtch.home_player_3_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_3_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_3_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_4_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_4_id,mtch.home_player_4_name,mtch.home_player_4_weight,to_timestamp(mtch.home_player_4_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_4_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_4_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_5_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_5_id,mtch.home_player_5_name,mtch.home_player_5_weight,to_timestamp(mtch.home_player_5_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_5_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_5_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_6_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_6_id,mtch.home_player_6_name,mtch.home_player_6_weight,to_timestamp(mtch.home_player_6_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_6_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_6_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_7_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_7_id,mtch.home_player_7_name,mtch.home_player_7_weight,to_timestamp(mtch.home_player_7_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_7_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_7_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_8_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_8_id,mtch.home_player_8_name,mtch.home_player_8_weight,to_timestamp(mtch.home_player_8_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_8_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_8_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_9_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_9_id,mtch.home_player_9_name,mtch.home_player_9_weight,to_timestamp(mtch.home_player_9_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_9_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_9_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_10_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_10_id,mtch.home_player_10_name,mtch.home_player_10_weight,to_timestamp(mtch.home_player_10_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_10_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_10_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.home_player_11_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.home_player_11_id,mtch.home_player_11_name,mtch.home_player_11_weight,to_timestamp(mtch.home_player_11_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.home_player_11_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.home_player_11_id,mtch.id,'casa') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_1_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_1_id,mtch.away_player_1_name,mtch.away_player_1_weight,to_timestamp(mtch.away_player_1_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_1_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_1_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_2_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_2_id,mtch.away_player_2_name,mtch.away_player_2_weight,to_timestamp(mtch.away_player_2_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_2_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_2_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_3_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_3_id,mtch.away_player_3_name,mtch.away_player_3_weight,to_timestamp(mtch.away_player_3_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_3_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_3_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_4_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_4_id,mtch.away_player_4_name,mtch.away_player_4_weight,to_timestamp(mtch.away_player_4_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_4_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_4_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_5_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_5_id,mtch.away_player_5_name,mtch.away_player_5_weight,to_timestamp(mtch.away_player_5_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_5_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_5_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_6_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_6_id,mtch.away_player_6_name,mtch.away_player_6_weight,to_timestamp(mtch.away_player_6_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_6_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_6_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_7_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_7_id,mtch.away_player_7_name,mtch.away_player_7_weight,to_timestamp(mtch.away_player_7_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_7_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_7_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_8_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_8_id,mtch.away_player_8_name,mtch.away_player_8_weight,to_timestamp(mtch.away_player_8_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_8_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_8_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_9_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_9_id,mtch.away_player_9_name,mtch.away_player_9_weight,to_timestamp(mtch.away_player_9_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_9_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_9_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_10_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_10_id,mtch.away_player_10_name,mtch.away_player_10_weight,to_timestamp(mtch.away_player_10_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_10_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_10_id,mtch.id,'trasferta') on conflict do nothing;
        end if;
        if max(coalesce(mtch.away_player_11_id,0)) > 0 then
            insert into giocatori(id,nome,peso,compleanno,altezza) values (mtch.away_player_11_id,mtch.away_player_11_name,mtch.away_player_11_weight,to_timestamp(mtch.away_player_11_birthday,'YYYY-MM-DD HH24:MI:SS')::date,mtch.away_player_11_height) on conflict do nothing;
            insert into temp_gioca(giocatore_id,incontro_id,posizione) values (mtch.away_player_11_id,mtch.id,'trasferta') on conflict do nothing;
        end if;





    end loop;
    delete from match *;
    return null;
END;
$$ LANGUAGE plpgsql security definer;

create TRIGGER update_incontri after insert on match execute procedure aggiungi_dati_incontri();
