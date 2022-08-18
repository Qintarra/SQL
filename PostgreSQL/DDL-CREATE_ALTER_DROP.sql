-- DDL Statements

CREATE DATABASE training_center;
--

CREATE SCHEMA training_data;
--

CREATE TABLE training_data.dim_groups
(
	group_id		BIGSERIAL PRIMARY KEY, -- constraint
	group_number	INTEGER NOT NULL, -- natural key
	creation_year	INTEGER DEFAULT EXTRACT (year FROM current_date),
	disband_year	INTEGER
);

INSERT INTO training_data.dim_groups (group_number)
VALUES (101);

SELECT * FROM training_data.dim_groups; -- check the value
--