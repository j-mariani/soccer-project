CREATE TABLE operazioni_quote (
    quota_id integer NOT NULL,
    nome_partner character varying(20) NOT NULL,
    data timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY operazioni_quote
    ADD CONSTRAINT operazioni_quote_pkey PRIMARY KEY (quota_id, nome_partner, data);

ALTER TABLE ONLY operazioni_quote
    ADD CONSTRAINT operazioni_quote_nome_partner_fkey FOREIGN KEY (nome_partner) 
    REFERENCES partner(nome_utente) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY operazioni_quote
    ADD CONSTRAINT operazioni_quote_quota_id_fkey FOREIGN KEY (quota_id) 
    REFERENCES quote(id) ON UPDATE CASCADE ON DELETE CASCADE;
