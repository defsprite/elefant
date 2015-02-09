CREATE SEQUENCE elephant_id_seq;

CREATE TABLE elephant_test_models (
    id integer not null default nextval('elephant_id_seq'::regclass) PRIMARY KEY,
    name character varying(255),
    number integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE INDEX elephant_index ON elephant_test_models USING btree (name);
