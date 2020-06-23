CREATE TABLE incontri (
    id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    goal_casa smallint NOT NULL,
    goal_trasferta smallint NOT NULL,
    lega character varying(50) NOT NULL,
    squadra_casa integer NOT NULL,
    squadra_trasferta integer NOT NULL
);

ALTER TABLE ONLY incontri
    ADD CONSTRAINT incontri_pkey PRIMARY KEY (id);

ALTER TABLE ONLY incontri
    ADD CONSTRAINT incontri_lega_fkey FOREIGN KEY (lega) 
    REFERENCES leghe(nome) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY incontri
    ADD CONSTRAINT incontri_squadra_casa_fkey FOREIGN KEY (squadra_casa) 
    REFERENCES squadre(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY incontri
    ADD CONSTRAINT incontri_squadra_trasferta_fkey FOREIGN KEY (squadra_trasferta) 
    REFERENCES squadre(id) ON UPDATE CASCADE ON DELETE CASCADE;
