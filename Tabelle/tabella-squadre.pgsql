CREATE TABLE squadre (
    id integer NOT NULL,
    nome character varying(3) NOT NULL,
    nome_lungo character varying(40) NOT NULL
);

ALTER TABLE ONLY squadre
    ADD CONSTRAINT squadre_pkey PRIMARY KEY (id);