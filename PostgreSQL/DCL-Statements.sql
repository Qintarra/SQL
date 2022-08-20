-- DCL Statements

GRANT SELECT ON TABLE film TO dvd_rental_client; -- grants privilege to extract data from table film
--

GRANT ALL ON TABLE	film TO	dvd_rental_admin; -- grants all available privileges for this table. Not recommended. Dangerous, but aacceptable.  
--

GRANT ALL ON TABLE film TO public; -- grants all privileges on table to public, i. e. all roles in the database. Prohibited. Dangerous and not acceptable.
--

REVOKE ALL IN TABLE film FROM public; -- remove dangerous privileges from public role 
--
