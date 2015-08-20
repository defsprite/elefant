CREATE SEQUENCE elefant_id_seq;

CREATE TABLE elefant_test_models (
    id integer not null default nextval('elefant_id_seq'::regclass) PRIMARY KEY,
    name character varying(255),
    number integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE INDEX elefant_index ON elefant_test_models USING btree (name);
