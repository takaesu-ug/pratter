-- Convert schema '/Users/yuji/workspace/perl/pratter_dbic/script/../sql/Pratter-Schema-1-MySQL.sql' to 'Pratter::Schema v1':;

BEGIN;

ALTER TABLE user ADD COLUMN login_name VARCHAR(255) NOT NULL;

INSERT INTO dbix_class_schema_versions (version, installed) VALUES (2, 'v20121225_013319.000');
COMMIT;

