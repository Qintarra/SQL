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

CREATE TABLE training_data.dim_trainees
(
	trainee_id		BIGSERIAL PRIMARY KEY,
	group_id		BIGINT NOT NULL REFERENCES training_data.dim_groups,
	first_name		TEXT NOT NULL,
	last_name		TEXT NOT NULL,
	full_name		TEXT GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED NOT NULL, -- stroed on disc after being generated
	birth_date		DATE NOT NULL,
	enrollment_year INTEGER DEFAULT EXTRACT (year FROM current_date) NOT NULL,
	graduation_year INTEGER
);

INSERT INTO training_data.dim_trainees(group_id, first_name, last_name, birth_date)
VALUES (1, 'Rocky', 'Balboa', '1945-07-06'::DATE)
--

/* - VIEW retrieves data at the time of access instead of storing it on disk
- executing DDL commands on views does not affect data in the database
- VIEW holds the query which references certain data projection */
CREATE VIEW active_trainees_snapshot AS

SELECT  g.group_id,
		g.group_number,
		t.trainee_id,
		t.full_name,
		current_date AS snapshot_date
FROM	training_data.dim_groups g 
JOIN 	training_data.dim_trainees t 
ON   	g.group_id = t.group_id
WHERE 	g.disband_year IS NULL;
--

-- Add a column
ALTER TABLE training_data.dim_trainees
ADD COLUMN education TEXT; -- new_colun_name DATA TYPE
--

-- Remove a column
ALTER TABLE training_data.dim_trainees
DROP COLUMN birth_date;
--