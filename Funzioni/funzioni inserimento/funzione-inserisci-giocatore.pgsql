create or replace function inserisci_giocatore(id integer, nome varchar(40),peso integer,compleanno date,altezza numeric) returns integer AS $$
declare
    num1 integer;
    num2 integer;
begin
    select count(giocatori.id) into num1 from giocatori;
    INSERT INTO giocatori(id,nome,peso,compleanno,altezza) values ($1,$2,$3,$4,$5) on conflict do nothing ;
    select count(giocatori.id) into num2 from giocatori;
    return num2-num1;
end;
$$ language plpgsql;