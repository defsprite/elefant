CREATE TABLE elephant_test_models (
    id integer primary key serial,
    name character varying(255),
    number integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);

CREATE INDEX index_name ON elephant_test_models USING btree (name);
