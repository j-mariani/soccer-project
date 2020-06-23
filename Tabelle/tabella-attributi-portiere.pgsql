CREATE TABLE attributi_portiere (
    giocatore_id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    picchiata smallint,
    posizionamento smallint,
    riflessi smallint,
    controllo smallint,
    rimessa smallint
);

ALTER TABLE ONLY attributi_portiere
    ADD CONSTRAINT attributi_portiere_pkey PRIMARY KEY (giocatore_id, data);

ALTER TABLE ONLY attributi_portiere
    ADD CONSTRAINT attributi_portiere_giocatore_id_fkey FOREIGN KEY (giocatore_id, data) 
        REFERENCES letture_attributi_giocatori(giocatore_id, data) ON UPDATE CASCADE ON DELETE CASCADE;
