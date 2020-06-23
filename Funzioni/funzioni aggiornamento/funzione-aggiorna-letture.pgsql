create or replace function aggiorna_letture(giocatore_id integer, data timestamp without time zone, valutazione_complessiva integer default null, potenziale integer default null , piede_preferito tipo_piede  default null , precisione_punizione integer  default null , visione integer  default null , tasso_offensivo tipo_tasso  default null , tasso_difensivo tipo_tasso  default null , precisione_testa integer  default null , salto integer  default null , riflessi integer  default null , agilita integer  default null , velocita integer  default null , stamina integer  default null , equilibrio integer  default null , forza integer  default null , accelerazione integer  default null , tiri integer  default null , tiri_al_volo integer  default null , passaggio_corto integer  default null , controllo_palla integer  default null , crossing integer  default null , tiro_in_porta integer  default null , passaggio_lungo integer  default null , potenza_tiro integer  default null , placcaggio integer  default null , scartaggio integer  default null , posizionamento integer  default null , curva integer  default null , aggressione integer  default null , scivolata integer  default null , spinta integer  default null , intercettazioni integer  default null , falli integer  default null , picchiata_portiere integer  default null , posizionamento_portiere integer  default null , riflessi_portiere integer  default null , controllo_portiere integer  default null , rimessa_portiere integer default null , nuovo_giocatore_id integer default null, nuova_data timestamp without time zone default null) returns integer AS $$
declare
    num1 integer;
    num2 integer;
    ngi integer;
    ck integer;
    ck2 timestamp without time zone;
    nd timestamp without time zone;
begin
    num1 = 0;
    ngi= nuovo_giocatore_id;
    nd = nuova_data;
    update letture_attributi_giocatori set 
        giocatore_id=coalesce(ngi,letture_attributi_giocatori.giocatore_id),
        data=coalesce(nd,letture_attributi_giocatori.data),
        valutazione_complessiva=coalesce($3,letture_attributi_giocatori.valutazione_complessiva),
        potenziale=coalesce($4,letture_attributi_giocatori.potenziale)
    where letture_attributi_giocatori.giocatore_id=$1 and letture_attributi_giocatori.data=$2;
    GET DIAGNOSTICS num2 = ROW_COUNT;
    num1 = num1 + num2;
    if($1 != ngi) then
        ck = ngi;
    else
        ck = $1;
    end if;
    if($2 != nd) then
        ck2 = nd;
    else
        ck2 = $2;
    end if;

    update attributi_standard set 
        piede_preferito=coalesce($5,attributi_standard.piede_preferito),
        precisione_punizione=coalesce($6,attributi_standard.precisione_punizione),
        visione=coalesce($7,attributi_standard.visione),
        tasso_offensivo=coalesce($8,attributi_standard.tasso_offensivo),
        tasso_difensivo=coalesce($9,attributi_standard.tasso_difensivo),
        precisione_testa=coalesce($10,attributi_standard.precisione_testa)

    where attributi_standard.giocatore_id=ck and attributi_standard.data=ck2;
    GET DIAGNOSTICS num2 = ROW_COUNT;
    num1 = num1 + num2;

    update attributi_fisici set 
        salto=coalesce($11,attributi_fisici.salto),
        riflessi=coalesce($12,attributi_fisici.riflessi),
        agilita=coalesce($13,attributi_fisici.agilita),
        velocita=coalesce($14,attributi_fisici.velocita),
        stamina=coalesce($15,attributi_fisici.stamina),
        equilibrio=coalesce($16,attributi_fisici.equilibrio),
        forza=coalesce($17,attributi_fisici.forza),
        accelerazione=coalesce($18,attributi_fisici.accelerazione)

    where attributi_fisici.giocatore_id=ck and attributi_fisici.data=ck2;
    GET DIAGNOSTICS num2 = ROW_COUNT;
    num1 = num1 + num2;

    update attributi_pallone set 
        tiri=coalesce($19,attributi_pallone.tiri),
        tiri_al_volo=coalesce($20,attributi_pallone.tiri_al_volo),
        passaggio_corto=coalesce($21,attributi_pallone.passaggio_corto),
        controllo_palla=coalesce($22,attributi_pallone.controllo_palla),
        crossing=coalesce($23,attributi_pallone.crossing),
        tiro_in_porta=coalesce($24,attributi_pallone.tiro_in_porta),
        passaggio_lungo=coalesce($25,attributi_pallone.passaggio_lungo),
        potenza_tiro=coalesce($26,attributi_pallone.potenza_tiro)

    where attributi_pallone.giocatore_id=ck and attributi_pallone.data=ck2;
    GET DIAGNOSTICS num2 = ROW_COUNT;
    num1 = num1 + num2;

    update attributi_placcaggio set 
        placcaggio=coalesce($27,attributi_placcaggio.placcaggio),
        scartaggio=coalesce($28,attributi_placcaggio.scartaggio),
        posizionamento=coalesce($29,attributi_placcaggio.posizionamento),
        curva=coalesce($30,attributi_placcaggio.curva),
        aggressione=coalesce($31,attributi_placcaggio.aggressione),
        scivolata=coalesce($32,attributi_placcaggio.scivolata),
        spinta=coalesce($33,attributi_placcaggio.spinta),
        intercettazioni=coalesce($34,attributi_placcaggio.intercettazioni),
        falli=coalesce($35,attributi_placcaggio.falli)

    where attributi_placcaggio.giocatore_id=ck and attributi_placcaggio.data=ck2;
    GET DIAGNOSTICS num2 = ROW_COUNT;
    num1 = num1 + num2;

    update attributi_portiere set 
        picchiata=coalesce($36,attributi_portiere.picchiata),
        posizionamento=coalesce($37,attributi_portiere.posizionamento),
        riflessi=coalesce($38,attributi_portiere.riflessi),
        controllo=coalesce($39,attributi_portiere.controllo),
        rimessa=coalesce($40,attributi_portiere.rimessa)

    where attributi_portiere.giocatore_id=ck and attributi_portiere.data=ck2;
    GET DIAGNOSTICS num2 = ROW_COUNT;
    num1 = num1 + num2;

    return num1;
end;
$$ language plpgsql;

