CREATE TABLE campionati (
    incontro_id integer NOT NULL,
    giornata integer NOT NULL,
    stagione character varying(9) NOT NULL
);

ALTER TABLE ONLY campionati
    ADD CONSTRAINT campionati_pkey PRIMARY KEY (incontro_id);

ALTER TABLE ONLY campionati
    ADD CONSTRAINT campionati_giornata_fkey FOREIGN KEY (giornata, stagione) 
    REFERENCES giornate(numero, stagione) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY campionati
    ADD CONSTRAINT campionati_incontro_id_fkey FOREIGN KEY (incontro_id) 
    REFERENCES incontri(id) ON UPDATE CASCADE ON DELETE CASCADE;
