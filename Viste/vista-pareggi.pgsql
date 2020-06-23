CREATE VIEW pareggi AS
    SELECT incontri.squadra_casa,
        incontri.squadra_trasferta,
        incontri.id AS incontro_id
    FROM incontri
    WHERE incontri.goal_casa = incontri.goal_trasferta;