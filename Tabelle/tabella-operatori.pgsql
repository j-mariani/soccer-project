CREATE TABLE operatori (
    nome_utente character varying(20) NOT NULL,
    password character varying(80) NOT NULL
);

ALTER TABLE ONLY operatori
    ADD CONSTRAINT operatori_pkey PRIMARY KEY (nome_utente);
