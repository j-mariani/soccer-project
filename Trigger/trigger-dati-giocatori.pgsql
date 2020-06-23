create or replace function aggiungi_dati_giocatori() returns trigger as $$
declare
    attr player_attribute%rowtype;
    data_attr timestamp;
    foot varchar(5);
    t_off varchar(6);
    t_dif varchar(6);
begin

    for attr in select * from player_attribute order by attribute_date
    loop
        if max(coalesce(attr.overall_rating,attr.potential,0)) > 0 then
            data_attr =  to_timestamp(attr.attribute_date,'YYYY-MM-DD HH24:MI:SS');
            insert into letture_attributi_giocatori(giocatore_id,data,potenziale,valutazione_complessiva) values (attr.player_id,data_attr,attr.potential,attr.overall_rating) on conflict do nothing;
            if (attr.preferred_foot='left' or attr.preferred_foot='right') then
                foot=attr.preferred_foot;
            ELSE
                foot=null;
            end if;
            if (attr.attacking_work_rate='high' or attr.attacking_work_rate='medium' or attr.attacking_work_rate='low') THEN
                t_off = attr.attacking_work_rate;
            ELSE
                t_off=null;
            end if;
            if (attr.defensive_work_rate='high' or attr.defensive_work_rate='medium' or attr.defensive_work_rate='low') THEN
                t_dif = attr.defensive_work_rate;
            else
                t_dif=null;
            end if;
            insert into attributi_standard(giocatore_id,data,precisione_punizione,visione,precisione_testa,piede_preferito,tasso_difensivo,tasso_offensivo) values (attr.player_id,data_attr,attr.free_kick_accuracy,attr.vision,attr.heading_accuracy,foot,t_dif,t_off) on conflict do nothing;

            insert into attributi_fisici(giocatore_id,data,salto,riflessi,agilita,velocita,accelerazione,forza,stamina,equilibrio) values (attr.player_id,data_attr,attr.jumping,attr.reactions,attr.agility,attr.sprint_speed,attr.acceleration,attr.strength,attr.stamina,attr.balance) on conflict do nothing;
            insert into attributi_pallone(giocatore_id,data,tiri,tiri_al_volo,passaggio_corto,controllo_palla,crossing,tiro_in_porta,passaggio_lungo,potenza_tiro) values (attr.player_id,data_attr,attr.long_shots,attr.volleys,attr.short_passing,attr.ball_control,attr.crossing,attr.finishing,attr.long_passing,attr.shot_power) on conflict do nothing;
            insert into attributi_placcaggio(giocatore_id,data,placcaggio,scartaggio,posizionamento,curva,aggressione,scivolata,intercettazioni,spinta,falli) values (attr.player_id,data_attr,attr.marking,attr.dribbling,attr.positioning,attr.curve,attr.aggression,attr.sliding_tackle,attr.interceptions,attr.standing_tackle,attr.penalties) on conflict do nothing;
            insert into attributi_portiere(giocatore_id,data,picchiata,posizionamento,riflessi,controllo,rimessa) values (attr.player_id,data_attr,attr.gk_diving,attr.gk_positioning,attr.gk_reflexes,attr.gk_handling,attr.gk_kicking) on conflict do nothing;
        end if;
    end loop;
    delete from player_attribute *;
    return null;
END;
$$ LANGUAGE plpgsql security DEFINER;

create TRIGGER update_dati_giocatori after insert on player_attribute execute procedure aggiungi_dati_giocatori();
