CREATE DOMAIN calcio.tipo_piede AS character varying(5) DEFAULT NULL::character varying
	CONSTRAINT tipo_piede_check 
        CHECK (((VALUE)::text = ANY 
            (ARRAY[
                ('left'::character varying)::text, 
                ('right'::character varying)::text])));
