CREATE TABLE quote (
    id integer NOT NULL,
    valore numeric NOT NULL,
    vittoria character varying(9) NOT NULL,
    incontro_id integer NOT NULL
);

CREATE SEQUENCE quote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE quote_id_seq OWNED BY quote.id;

ALTER TABLE ONLY quote ALTER COLUMN id SET 
    DEFAULT nextval('quote_id_seq'::regclass);

ALTER TABLE ONLY quote
    ADD CONSTRAINT quote_pkey PRIMARY KEY (id);

ALTER TABLE ONLY quote
    ADD CONSTRAINT quote_incontro_id_fkey FOREIGN KEY (incontro_id) 
    REFERENCES incontri(id) ON UPDATE CASCADE ON DELETE CASCADE;
