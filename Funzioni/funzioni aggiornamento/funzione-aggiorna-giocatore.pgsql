create or replace function aggiorna_giocatore(id integer, nome varchar(40) default null,peso integer default null,compleanno date default null,altezza numeric default null, nuovo_id integer default null) returns integer AS $$
declare
    num1 integer;
begin
    update giocatori set
        id=coalesce($6,giocatori.id), 
        nome=coalesce($2,giocatori.nome),
        peso=coalesce($3,giocatori.peso),
        compleanno=coalesce($4,giocatori.compleanno),
        altezza=coalesce($5,giocatori.altezza)
    where giocatori.id=$1;

    GET DIAGNOSTICS num1 = ROW_COUNT;
    return num1;
end;
$$ language plpgsql;