CREATE VIEW classifica_squadre_lega AS
    SELECT punteggi_lega.lega,
        squadre.nome_lungo AS nome_squadra,
        punteggi_lega.punteggio,
        punteggi_lega.stagione
    FROM punteggi_lega() punteggi_lega(lega, squadra, punteggio, stagione)
        JOIN squadre ON punteggi_lega.squadra = squadre.id;