CREATE VIEW vittorie AS 
    SELECT incontri.squadra_casa AS squadra,
        incontri.id AS incontro_id
    FROM incontri
    WHERE incontri.goal_casa > incontri.goal_trasferta
    UNION
    SELECT incontri.squadra_trasferta AS squadra,
        incontri.id AS incontro_id
    FROM incontri
    WHERE incontri.goal_trasferta > incontri.goal_casa;