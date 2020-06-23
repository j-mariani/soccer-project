CREATE TABLE attributi_placcaggio (
    giocatore_id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    placcaggio smallint,
    scartaggio smallint,
    posizionamento smallint,
    curva smallint,
    aggressione smallint,
    scivolata smallint,
    intercettazioni smallint,
    spinta smallint,
    falli smallint
);

ALTER TABLE ONLY attributi_placcaggio
    ADD CONSTRAINT attributi_placcaggio_pkey PRIMARY KEY (giocatore_id, data);

ALTER TABLE ONLY attributi_placcaggio
    ADD CONSTRAINT attributi_placcaggio_giocatore_id_fkey FOREIGN KEY (giocatore_id, data) 
        REFERENCES letture_attributi_giocatori(giocatore_id, data) ON UPDATE CASCADE ON DELETE CASCADE;
