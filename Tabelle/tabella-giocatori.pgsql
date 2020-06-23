CREATE TABLE giocatori (
    id integer NOT NULL,
    nome character varying(40) NOT NULL,
    peso integer NOT NULL,
    compleanno date NOT NULL,
    altezza numeric NOT NULL
);

ALTER TABLE ONLY giocatori
    ADD CONSTRAINT giocatori_pkey PRIMARY KEY (id);
