CREATE VIEW giocatori_match AS
    SELECT incontri.id AS incontro_id,
        incontri.data AS data_incontro,
        gioca.giocatore_id,
        giocatori.nome AS giocatore_nome,
        CASE
            WHEN gioca.posizione::text = 'trasferta'::text THEN s1.nome
            WHEN gioca.posizione::text = 'casa'::text THEN s2.nome
            ELSE NULL::character varying
        END AS squadra_nome,
        CASE
            WHEN gioca.posizione::text = 'trasferta'::text THEN s1.id
            WHEN gioca.posizione::text = 'casa'::text THEN s2.id
            ELSE NULL::integer
        END AS squadra_id
    FROM gioca
        JOIN incontri ON incontri.id = gioca.incontro_id
        JOIN giocatori ON gioca.giocatore_id = giocatori.id
        JOIN squadre s1 ON s1.id = incontri.squadra_trasferta
        JOIN squadre s2 ON s2.id = incontri.squadra_casa;