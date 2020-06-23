create or replace function inserisci_letture(giocatore_id integer, data timestamp without time zone, valutazione_complessiva integer default null, potenziale integer default null , piede_preferito tipo_piede  default null , precisione_punizione integer  default null , visione integer  default null , tasso_offensivo tipo_tasso  default null , tasso_difensivo tipo_tasso  default null , precisione_testa integer  default null , salto integer  default null , riflessi integer  default null , agilita integer  default null , velocita integer  default null , stamina integer  default null , equilibrio integer  default null , forza integer  default null , accelerazione integer  default null , tiri integer  default null , tiri_al_volo integer  default null , passaggio_corto integer  default null , controllo_palla integer  default null , crossing integer  default null , tiro_in_porta integer  default null , passaggio_lungo integer  default null , potenza_tiro integer  default null , placcaggio integer  default null , scartaggio integer  default null , posizionamento integer  default null , curva integer  default null , aggressione integer  default null , scivolata integer  default null , spinta integer  default null , intercettazioni integer  default null , falli integer  default null , picchiata_portiere integer  default null , posizionamento_portiere integer  default null , riflessi_portiere integer  default null , controllo_portiere integer  default null , rimessa_portiere integer default null) returns integer AS $$
declare
    num1 integer;
    num2 integer;
    num3 integer;
begin
    select count(letture_attributi_giocatori.giocatore_id) into num1 from letture_attributi_giocatori;
    INSERT INTO letture_attributi_giocatori(giocatore_id,data,valutazione_complessiva,potenziale) values (giocatore_id,data,valutazione_complessiva,potenziale) on conflict do nothing;
    INSERT INTO attributi_standard(giocatore_id,data,piede_preferito , precisione_punizione , visione , tasso_offensivo , tasso_difensivo , precisione_testa) values (giocatore_id,data,piede_preferito , precisione_punizione , visione , tasso_offensivo , tasso_difensivo , precisione_testa) on conflict do nothing;
    INSERT INTO attributi_fisici(giocatore_id,data,salto , riflessi , agilita , velocita , stamina , equilibrio , forza , accelerazione) values (giocatore_id,data,salto , riflessi , agilita , velocita , stamina , equilibrio , forza , accelerazione) on conflict do nothing;
    INSERT INTO attributi_pallone(giocatore_id,data,tiri , tiri_al_volo , passaggio_corto , controllo_palla , crossing , tiro_in_porta , passaggio_lungo , potenza_tiro) values (giocatore_id,data,tiri , tiri_al_volo , passaggio_corto , controllo_palla , crossing , tiro_in_porta , passaggio_lungo , potenza_tiro) on conflict do nothing;
    INSERT INTO attributi_placcaggio(giocatore_id,data,placcaggio , scartaggio , posizionamento , curva , aggressione , scivolata , spinta , intercettazioni , falli) values (giocatore_id,data,placcaggio , scartaggio , posizionamento , curva , aggressione , scivolata , spinta , intercettazioni , falli) on conflict do nothing;
    INSERT INTO attributi_portiere(giocatore_id,data,picchiata , posizionamento , riflessi , controllo , rimessa) values (giocatore_id,data,picchiata_portiere , posizionamento_portiere , riflessi_portiere , controllo_portiere , rimessa_portiere) on conflict do nothing;

    select count(letture_attributi_giocatori.giocatore_id) into num2 from letture_attributi_giocatori;
    return num2-num1;
end;
$$ language plpgsql;

