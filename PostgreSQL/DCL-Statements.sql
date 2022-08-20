-- DCL Statements

GRANT SELECT ON TABLE film TO dvd_rental_client; -- grants privilege to extract data from table film
--

GRANT ALL ON TABLE	film TO	dvd_rental_admin; -- grants all available privileges for this table. Not recommended. Dangerous, but aacceptable.  
--

GRANT ALL ON TABLE film TO public; -- grants all privileges on table to public, i. e. all roles in the database. Prohibited. Dangerous and not acceptable.
--

REVOKE ALL IN TABLE film FROM public; -- remove dangerous privileges from public role 
--

GRANT EXECUTE ON FUNCTION list_recent_films TO public; -- allow all users to invoke function list_recent_films
--

GRANT CREATE ON SCHEMA dvd_rental to dvd_rentail_admin; -- allow dvd_rentail_admin to manage objects in a schema
--

GRANT ALL ON ALL TABLES IN SCHEMA dvd_rental TO dvd_rentail_admin; -- allow to perform DML on all tables in schema
--

GRANT CONNECT TO client_ben -- allow role client_ben to authenticate into the database. client_ben role needs to be created with LOGIN option 
--