CREATE TABLE attributi_pallone (
    giocatore_id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    tiri smallint,
    tiri_al_volo smallint,
    passaggio_corto smallint,
    controllo_palla smallint,
    crossing smallint,
    tiro_in_porta smallint,
    passaggio_lungo smallint,
    potenza_tiro smallint
);

ALTER TABLE ONLY attributi_pallone
    ADD CONSTRAINT attributi_pallone_pkey PRIMARY KEY (giocatore_id, data);

ALTER TABLE ONLY attributi_pallone
    ADD CONSTRAINT attributi_pallone_giocatore_id_fkey FOREIGN KEY (giocatore_id, data) 
        REFERENCES letture_attributi_giocatori(giocatore_id, data) ON UPDATE CASCADE ON DELETE CASCADE;
