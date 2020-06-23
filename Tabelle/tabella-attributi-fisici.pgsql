CREATE TABLE attributi_fisici (
    giocatore_id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    salto smallint,
    riflessi smallint,
    agilita smallint,
    velocita smallint,
    accelerazione smallint,
    forza smallint,
    stamina smallint,
    equilibrio smallint
);

ALTER TABLE ONLY attributi_fisici
    ADD CONSTRAINT attributi_fisici_pkey PRIMARY KEY (giocatore_id, data);

ALTER TABLE ONLY attributi_fisici
    ADD CONSTRAINT attributi_fisici_giocatore_id_fkey FOREIGN KEY (giocatore_id, data) 
        REFERENCES letture_attributi_giocatori(giocatore_id, data) ON UPDATE CASCADE ON DELETE CASCADE;
