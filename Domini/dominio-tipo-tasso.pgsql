CREATE DOMAIN calcio.tipo_tasso AS character varying(6) DEFAULT NULL::character varying
	CONSTRAINT tipo_tasso_check 
        CHECK (((VALUE)::text = ANY 
            (ARRAY[
                ('high'::character varying)::text, 
                ('medium'::character varying)::text, 
                ('low'::character varying)::text])));