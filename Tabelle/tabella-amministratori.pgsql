CREATE TABLE amministratori (
    nome_utente character varying(20) NOT NULL,
    password character varying(80) NOT NULL
);

ALTER TABLE ONLY amministratori
    ADD CONSTRAINT amministratori_pkey PRIMARY KEY (nome_utente);