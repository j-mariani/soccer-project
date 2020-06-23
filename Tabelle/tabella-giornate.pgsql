CREATE TABLE giornate (
    numero integer NOT NULL,
    stagione character varying(9) NOT NULL
);

ALTER TABLE ONLY giornate
    ADD CONSTRAINT giornate_pkey PRIMARY KEY (numero, stagione);

