CREATE TABLE societa (
    id integer NOT NULL,
    nome character varying(10) NOT NULL
);

ALTER TABLE ONLY societa
    ADD CONSTRAINT societa_pkey PRIMARY KEY (id);
