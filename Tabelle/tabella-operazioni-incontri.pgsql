CREATE TABLE operazioni_incontri (
    incontro_id integer NOT NULL,
    nome_operatore character varying(20) NOT NULL,
    data timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY operazioni_incontri
    ADD CONSTRAINT operazioni_incontri_pkey PRIMARY KEY (incontro_id, nome_operatore, data);

ALTER TABLE ONLY operazioni_incontri
    ADD CONSTRAINT operazioni_incontri_incontro_id_fkey FOREIGN KEY (incontro_id) 
    REFERENCES incontri(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY operazioni_incontri
    ADD CONSTRAINT operazioni_incontri_nome_operatore_fkey FOREIGN KEY (nome_operatore) 
    REFERENCES operatori(nome_utente) ON UPDATE CASCADE ON DELETE CASCADE;
