CREATE TABLE leghe (
    nome character varying(50) NOT NULL,
    nazione character varying(10) NOT NULL
);

ALTER TABLE ONLY leghe
    ADD CONSTRAINT leghe_pkey PRIMARY KEY (nome);
