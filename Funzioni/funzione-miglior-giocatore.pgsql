create or replace function miglior_giocatore(incontro_id integer) returns table(nome varchar(30), valutazione_complessiva smallint, squadra varchar(3), posizione varchar(9)) AS $$
begin
    return query
    select * from (select * from classifica_giocatori($1) as bar
        where bar.valutazione_complessiva = 
            (select max(foo.valutazione_complessiva) from classifica_giocatori($1) as foo where foo.posizione='casa') 
        and bar.posizione='casa'
        union
        select * from classifica_giocatori($1) as bar
        where bar.valutazione_complessiva = 
            (select max(foo.valutazione_complessiva) from classifica_giocatori($1) as foo where foo.posizione='trasferta') 
        and bar.posizione='trasferta') as dummy
    order by dummy.valutazione_complessiva desc;
    end
$$ language plpgsql security definer;