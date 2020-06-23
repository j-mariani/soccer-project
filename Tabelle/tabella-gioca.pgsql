CREATE TABLE gioca (
    giocatore_id integer NOT NULL,
    incontro_id integer NOT NULL,
    posizione character varying(9) NOT NULL,
    CONSTRAINT gioca_posizione_check CHECK (((posizione)::text = ANY 
        (ARRAY[('casa'::character varying)::text, 
            ('trasferta'::character varying)::text])))
);

ALTER TABLE ONLY gioca
    ADD CONSTRAINT gioca_pkey PRIMARY KEY (giocatore_id, incontro_id);

ALTER TABLE ONLY gioca
    ADD CONSTRAINT gioca_giocatore_id_fkey FOREIGN KEY (giocatore_id) 
    REFERENCES giocatori(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY gioca
    ADD CONSTRAINT gioca_incontro_id_fkey FOREIGN KEY (incontro_id) 
    REFERENCES incontri(id) ON UPDATE CASCADE ON DELETE CASCADE;
