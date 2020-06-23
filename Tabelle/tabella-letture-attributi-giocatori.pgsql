CREATE TABLE letture_attributi_giocatori (
    giocatore_id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    valutazione_complessiva smallint,
    potenziale smallint
);

ALTER TABLE ONLY letture_attributi_giocatori
    ADD CONSTRAINT letture_attributi_giocatori_pkey PRIMARY KEY (giocatore_id, data);

ALTER TABLE ONLY letture_attributi_giocatori
    ADD CONSTRAINT letture_attributi_giocatori_giocatore_id_fkey FOREIGN KEY (giocatore_id) 
    REFERENCES giocatori(id) ON UPDATE CASCADE ON DELETE CASCADE;
