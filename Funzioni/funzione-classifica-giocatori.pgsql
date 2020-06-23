create or replace function classifica_giocatori(incontro_id integer) returns table(nome varchar(30), valutazione_complessiva smallint, squadra varchar(3), posizione varchar(9)) AS $$
begin
    return query
select giocatori.nome,letture_attributi_giocatori.valutazione_complessiva,giocatori_match.squadra_nome,gioca.posizione from letture_attributi_giocatori join 
        (select letture_attributi_giocatori.giocatore_id,max(letture_attributi_giocatori.data)
        from giocatori_match join gioca on giocatori_match.incontro_id=gioca.incontro_id
        join giocatori on gioca.giocatore_id=giocatori.id
        join letture_attributi_giocatori on giocatori.id=letture_attributi_giocatori.giocatore_id
        where letture_attributi_giocatori.data<=giocatori_match.data_incontro 
        and giocatori_match.incontro_id=$1
        group by letture_attributi_giocatori.giocatore_id) as foo
    on foo.giocatore_id=letture_attributi_giocatori.giocatore_id
    and foo.max=letture_attributi_giocatori.data join
    giocatori on foo.giocatore_id=giocatori.id join
    giocatori_match on giocatori_match.incontro_id=$1 and foo.giocatore_id=giocatori_match.giocatore_id join
    gioca on gioca.incontro_id=$1 and foo.giocatore_id=gioca.giocatore_id
    order by posizione,valutazione_complessiva desc;
    end
$$ language plpgsql security definer;

