CREATE TABLE attributi_standard (
    giocatore_id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    piede_preferito tipo_piede,
    precisione_punizione smallint,
    visione smallint,
    tasso_offensivo tipo_tasso,
    tasso_difensivo tipo_tasso,
    precisione_testa smallint
);

ALTER TABLE ONLY attributi_standard
    ADD CONSTRAINT attributi_standard_pkey PRIMARY KEY (giocatore_id, data);

ALTER TABLE ONLY attributi_standard
    ADD CONSTRAINT attributi_standard_giocatore_id_fkey FOREIGN KEY (giocatore_id, data) 
        REFERENCES letture_attributi_giocatori(giocatore_id, data) ON UPDATE CASCADE ON DELETE CASCADE;
