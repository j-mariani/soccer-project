CREATE TABLE partner (
    nome_utente character varying(20) NOT NULL,
    societa integer NOT NULL,
    password character varying(80) NOT NULL
);

ALTER TABLE ONLY partner
    ADD CONSTRAINT partner_pkey PRIMARY KEY (nome_utente);

ALTER TABLE ONLY partner
    ADD CONSTRAINT partner_societa_fkey FOREIGN KEY (societa) 
        REFERENCES societa(id) ON UPDATE CASCADE ON DELETE CASCADE;
